defmodule Elixre do
  @moduledoc """
  Back end for Elixre.
  """
  use Plug.Router

  if Mix.env != :test do
    plug Plug.Logger
  end

  plug Plug.NormalizeRootRequests
  plug Plug.Parsers,
    parsers: [:json],
    pass: ["*/*"],
    json_decoder: Poison
  plug Plug.Static, at: "/", from: "public"
  plug :match
  plug :dispatch

  post "/regex" do
    list = conn.body_params["_json"]
    reversed = list |> Enum.reverse
    IO.inspect conn.body_params
    json = Poison.encode!(reversed)
    IO.inspect json

    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, json)
  end

  match _ do
    send_resp(conn, 404, "Page not found")
  end
end
