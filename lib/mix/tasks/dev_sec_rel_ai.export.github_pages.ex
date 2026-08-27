defmodule Mix.Tasks.DevSecRelAi.Export.GithubPages do
  @moduledoc """
  Exports DevSecRelAI's public routes as a static site for GitHub Pages.
  """

  use Mix.Task

  import Phoenix.ConnTest
  import Plug.Conn, only: [put_req_header: 3]

  alias DevSecRelAI.{Lessons, LocaleInfo, Posts}

  @endpoint DevSecRelAIWeb.Endpoint
  @default_output "github-pages"

  @impl Mix.Task
  def run(args) do
    {options, remaining, invalid} = OptionParser.parse(args, strict: [output: :string])

    if remaining != [] or invalid != [] do
      Mix.raise("usage: mix dev_sec_rel_ai.export.github_pages [--output github-pages]")
    end

    output = options[:output] || @default_output

    Mix.Task.run("compile")
    Mix.Task.run("app.start")

    output
    |> prepare_output!()
    |> export!()
  end

  defp prepare_output!(output) do
    output = Path.expand(output)

    if Path.basename(output) != @default_output do
      Mix.raise("the output directory must be named #{@default_output}")
    end

    File.rm_rf!(output)
    File.mkdir_p!(output)
    output
  end

  defp export!(output) do
    ensure_static_assets!()
    copy_static_files!(output)
    File.write!(Path.join(output, ".nojekyll"), "")

    pages =
      all_routes()
      |> Enum.map(&{&1, render_page!(&1)})
      |> Map.new()

    Enum.each(pages, fn {route, html} ->
      write_page!(output, route, static_html(html))
    end)

    write_page!(output, "/", static_html(Map.fetch!(pages, "/en")))
    File.write!(Path.join(output, "404.html"), static_html(render_page!("/github-pages-not-found", 404)))

    Mix.shell().info("Exported #{map_size(pages) + 2} pages to #{output}")
  end

  defp ensure_static_assets! do
    unless File.dir?("priv/static/assets") do
      Mix.raise("static assets are missing; run mix assets.deploy before exporting GitHub Pages")
    end
  end

  defp copy_static_files!(output) do
    "priv/static"
    |> File.ls!()
    |> Enum.each(fn entry ->
      File.cp_r!(Path.join("priv/static", entry), Path.join(output, entry))
    end)
  end

  defp all_routes do
    ["/privacy", "/blog"] ++ post_routes() ++ locale_routes()
    |> Enum.uniq()
    |> Enum.sort()
  end

  defp post_routes do
    pages = Posts.pages()

    pagination_routes =
      if pages > 1 do
        Enum.map(1..(pages - 1), &"/blog?page=#{&1}")
      else
        []
      end

    posts =
      for page <- 0..(pages - 1), post <- Posts.page(page) do
        "/blog/#{URI.encode_www_form(post.slug)}"
      end

    tag_routes =
      Posts.tag_cloud()
      |> Map.keys()
      |> Enum.map(&"/blog/tag/#{URI.encode_www_form(&1)}")

    pagination_routes ++ posts ++ tag_routes
  end

  defp locale_routes do
    sections = Keyword.keys(Application.fetch_env!(:dev_sec_rel_ai, :lessons))

    LocaleInfo.list()
    |> Enum.flat_map(fn locale ->
      [
        "/#{locale}",
        "/#{locale}/why",
        "/#{locale}/get_involved",
        "/#{locale}/podcasts",
        "/#{locale}/conferences",
        "/#{locale}/report"
      ] ++ section_routes(locale, sections)
    end)
  end

  defp section_routes(locale, sections) do
    Enum.flat_map(sections, fn section ->
      ["/#{locale}/lessons/#{section}" | lesson_routes(locale, section)]
    end)
  end

  defp lesson_routes(locale, section) do
    lessons = Application.fetch_env!(:dev_sec_rel_ai, :lessons)[section]

    for lesson <- lessons,
        match?({:ok, _}, Lessons.get(section, lesson, locale)) do
      "/#{locale}/lessons/#{section}/#{lesson}"
    end
  end

  defp render_page!(route, expected_status \\ 200) do
    conn =
      build_conn()
      |> put_req_header("accept", "text/html")
      |> get(route)

    if conn.status != expected_status do
      Mix.raise("expected #{route} to render #{expected_status}, got #{conn.status}")
    end

    conn.resp_body
  end

  defp write_page!(output, route, html) do
    destination = Path.join(output, output_path(route))
    File.mkdir_p!(Path.dirname(destination))
    File.write!(destination, html)
  end

  defp output_path(route) do
    uri = URI.parse(route)
    path = uri.path |> String.trim_leading("/") |> String.split("/", trim: true)

    case uri.query do
      nil -> Path.join(path ++ ["index.html"])
      "page=" <> page -> Path.join(path ++ ["page", page, "index.html"])
      query -> Mix.raise("unsupported static query string: #{query}")
    end
  end

  defp static_html(html) do
    html
    |> rewrite_blog_pagination()
    |> String.replace(~r/\sdata-phx-[\w-]+="[^"]*"/, "")
    |> String.replace(~r/\sphx-[\w-]+="[^"]*"/, "")
  end

  defp rewrite_blog_pagination(html) do
    Regex.replace(~r/href="\/blog\?page=(\d+)"/, html, fn _match, page ->
      "href=\"#{blog_page_path(page)}\""
    end)
  end

  defp blog_page_path("0"), do: "/blog/"
  defp blog_page_path(page), do: "/blog/page/#{page}/"
end
