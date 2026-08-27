#!/usr/bin/env elixir

defmodule DevSecRelAI.TranslationReport do
  @lessons_dir Path.expand("../lessons", __DIR__)
  @statuses ~w(current patch minor major missing)

  def run(args) do
    {options, _rest, _invalid} = OptionParser.parse(args, strict: [lang: :string, severity: :string])
    english_versions = lessons_for("en")

    locales()
    |> List.delete("en")
    |> filter_locales(options[:lang])
    |> Enum.each(fn locale ->
      rows =
        english_versions
        |> rows_for(lessons_for(locale))
        |> filter_statuses(options[:severity])

      if rows != [] do
        print_report(locale, rows)
      end
    end)
  end

  defp locales do
    @lessons_dir
    |> File.ls!()
    |> Enum.filter(&File.dir?(Path.join(@lessons_dir, &1)))
    |> Enum.sort()
  end

  defp filter_locales(locales, nil), do: locales

  defp filter_locales(locales, filter) do
    allowed = String.split(filter, ",", trim: true)
    Enum.filter(locales, &(&1 in allowed))
  end

  defp lessons_for(locale) do
    @lessons_dir
    |> Path.join(locale)
    |> Path.join("**/*.md")
    |> Path.wildcard()
    |> Map.new(fn path ->
      relative = Path.relative_to(path, Path.join(@lessons_dir, locale))
      {Path.rootname(relative), version_from(path)}
    end)
  end

  defp version_from(path) do
    case Regex.run(~r/version:\s*"([^"]+)"/, File.read!(path)) do
      [_, version] -> version
      nil -> nil
    end
  end

  defp rows_for(english, translations) do
    english
    |> Enum.sort_by(fn {lesson, _version} -> lesson end)
    |> Enum.map(fn {lesson, english_version} ->
      translation_version = Map.get(translations, lesson)
      {lesson, english_version, translation_version, compare(english_version, translation_version)}
    end)
  end

  defp filter_statuses(rows, nil), do: rows

  defp filter_statuses(rows, filter) do
    statuses = String.split(filter, ",", trim: true)
    Enum.filter(rows, fn {_lesson, _english, _translation, status} -> status in statuses end)
  end

  defp compare(_english, nil), do: "missing"
  defp compare(english, translation) when english == translation, do: "current"

  defp compare(english, translation) do
    case {parse_version(english), parse_version(translation)} do
      {{english_major, english_minor, english_patch}, {translation_major, translation_minor, translation_patch}} ->
        cond do
          translation_major < english_major -> "major"
          translation_minor < english_minor -> "minor"
          translation_patch < english_patch -> "patch"
          true -> "current"
        end

      _ -> "major"
    end
  end

  defp parse_version(version) when is_binary(version) do
    case version |> String.split(".") |> Enum.map(&Integer.parse/1) do
      [{major, ""}, {minor, ""}, {patch, ""}] -> {major, minor, patch}
      _ -> nil
    end
  end

  defp parse_version(_), do: nil

  defp print_report(locale, rows) do
    IO.puts("\n=== #{locale} ===")
    IO.puts("Lesson  English  #{String.pad_trailing(locale, 8)}Status")

    Enum.each(rows, fn {lesson, english, translation, status} ->
      IO.puts(
        "#{String.pad_trailing(lesson, 24)} #{String.pad_trailing(english || "?", 8)} " <>
          "#{String.pad_trailing(translation || "—", 8)} #{status}"
      )
    end)

    summary =
      rows
      |> Enum.frequencies_by(fn {_lesson, _english, _translation, status} -> status end)
      |> then(fn counts ->
        @statuses
        |> Enum.filter(&Map.has_key?(counts, &1))
        |> Enum.map_join(", ", fn status -> "#{counts[status]} #{status}" end)
      end)

    IO.puts("Summary: #{summary}")
  end
end

DevSecRelAI.TranslationReport.run(System.argv())
