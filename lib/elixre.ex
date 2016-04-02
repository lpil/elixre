defmodule Elixre do
  @moduledoc """
  Back end for Elixre.
  """
  use Plug.Router
  plug :match
  plug :dispatch

  get "/" do
    send_resp(conn, 200, "hello dinosaur")
  end
end
