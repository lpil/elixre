defmodule RegTest.PageController do
  use RegTest.Web, :controller

  plug :action

  def index(conn, _params) do
    render conn, "index.html"
  end
end
