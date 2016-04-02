defmodule Elixre do
  @moduledoc """
  Back end for Elixre.
  """
  use Plug.Router

  if Mix.env != :test do
    plug Plug.Logger
  end
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "hello dinosaur")
  end
end
