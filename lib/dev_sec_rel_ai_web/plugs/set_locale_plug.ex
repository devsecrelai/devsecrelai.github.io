defmodule DevSecRelAIWeb.SetLocalePlug do
  @moduledoc """
  Set the process' locale given the path params value
  """

  import Plug.Conn, only: [put_status: 2, halt: 1]
  import Phoenix.Controller, only: [put_view: 2, render: 2]
  alias DevSecRelAI.LocaleInfo

  @spec init(any) :: any
  def init(opts), do: opts

  @spec call(Plug.Conn.t(), any) :: Plug.Conn.t()
  def call(conn, _opts) do
    locale = Map.get(conn.path_params, "locale", default_locale())

    case valid_locale?(locale) do
      true ->
        Gettext.put_locale(DevSecRelAIWeb.Gettext, locale)
        conn

      false ->
        conn
        |> put_status(404)
        |> put_view(DevSecRelAIWeb.ErrorView)
        |> render("404.html")
        |> halt()
    end
  end

  defp valid_locale?(locale) do
    Enum.member?(valid_locales(), locale)
  end

  defp default_locale do
    LocaleInfo.default_locale()
  end

  defp valid_locales do
    LocaleInfo.list()
  end
end
