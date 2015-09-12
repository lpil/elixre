defmodule Elixre.Endpoint do
  @moduledoc false

  use Phoenix.Endpoint, otp_app: :elixre

  # Serve at "/" the given assets from "priv/static" directory
  plug Plug.Static,
    at: "/", from: :elixre,
    only: ~w(
      favicon.ico
      humans.txt
      images
      main.css
      main.css.map
      main.js
      robots.txt
    )

  plug Plug.Logger

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    socket "/phoenix/live_reload/socket", Phoenix.LiveReloader.Socket
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_elixre_key",
    signing_salt: "OfvwamQP"

  plug Elixre.Router
end
