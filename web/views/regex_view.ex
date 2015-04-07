defmodule Elixre.RegexView do
  use Elixre.Web, :view

  def render("result.json", %{data: data}) do
    data
  end
end
