defmodule Elixre.PageController do
  @moduledoc """
  Responsible for service static pages, such as the home page.
  """

  use Elixre.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
