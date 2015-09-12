defmodule Elixre.RegexView do
  @moduledoc """
  Views for the regex controller
  """

  use Elixre.Web, :view

  def render("result.json", %{data: data}) do
    data
  end
end
