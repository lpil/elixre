defmodule Elixre.Endpoint do
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

  # Code reloading will only work if the :code_reloader key of
  # the :phoenix application is set to true in your config file.
  plug Phoenix.CodeReloader

  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_elixre_key",
    signing_salt: "OfvwamQP",
    encryption_salt: "Ar/vd12f"

  plug :router, Elixre.Router
end
