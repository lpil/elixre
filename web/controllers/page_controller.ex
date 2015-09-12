defmodule Elixre.PageController do
  use Elixre.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
