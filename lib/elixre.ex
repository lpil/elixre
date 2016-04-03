defmodule Elixre do
  @moduledoc """
  Back end for Elixre.
  """
  use Plug.Router

  if Mix.env != :test do
    plug Plug.Logger
  end

  plug Plug.Static, at: "/", from: "public"
  plug :match
  plug :dispatch

  @html File.read!("public/index.html")
  get "/" do
    send_resp(conn, 200, @html)
  end

  match _ do
    send_resp(conn, 404, "Page not found")
  end
end
