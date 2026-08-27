defmodule DevSecRelAIWeb.ReportController do
  use DevSecRelAIWeb, :controller

  alias DevSecRelAI.Lessons

  def index(conn, %{"locale" => locale}) do
    render(conn, "report.html", report: Lessons.translation_report(locale))
  end
end
