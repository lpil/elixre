defmodule Elixre do
  @moduledoc """
  Back end for Elixre.
  """
  use Plug.Router

  if Mix.env != :test do
    plug Plug.Logger
  end

  plug Plug.NormalizeRootRequests
  plug Plug.Static, at: "/", from: "public"
  plug :match
  plug :dispatch

  match _ do
    send_resp(conn, 404, "Page not found")
  end
end
