defmodule DevSecRelAI.LocalesTest do
  use ExUnit.Case

  alias DevSecRelAI.LocaleInfo

  test "Locales in LocaleInfo are same as in config" do
    assert LocaleInfo.list() == Application.get_env(:dev_sec_rel_ai, DevSecRelAIWeb.Gettext)[:locales]
  end
end
