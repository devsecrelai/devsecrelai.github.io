defmodule DevSecRelAIWeb.ReportController do
  use DevSecRelAIWeb, :controller

  alias DevSecRelAI.Lessons

  def index(conn, %{"locale" => locale}) do
    sections =
      :dev_sec_rel_ai
      |> Application.fetch_env!(:lessons)
      |> Keyword.keys()

    render(conn, "report.html", report: Lessons.translation_report(locale), sections: sections)
  end
end
