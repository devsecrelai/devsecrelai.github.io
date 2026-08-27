defmodule DevSecRelAIWeb.ErrorViewTest do
  use DevSecRelAIWeb.ConnCase, async: true

  # Bring render/3 and render_to_string/3 for testing custom views
  import Phoenix.View

  test "renders 404.html" do
    assert render_to_string(DevSecRelAIWeb.ErrorView, "404.html", conn: build_conn()) =~ "Page not found"
  end

  test "renders 500.html" do
    assert render_to_string(DevSecRelAIWeb.ErrorView, "500.html", conn: build_conn()) =~ "Internal Server Error"
  end

  test "renders translation_missing.html" do
    assert render_to_string(DevSecRelAIWeb.ErrorView, "translation_missing.html",
             conn: build_conn(),
             missing_locale: "no"
           ) =~
             "Translation unavailable"
  end
end
