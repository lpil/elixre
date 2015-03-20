defmodule Elixre.PageController do
  use Elixre.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
