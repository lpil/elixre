import Config

case Mix.env() do
  :dev ->
    config :elixre,
      start_http: true,
      build_frontend: true

  :prod ->
    config :elixre,
      start_http: true,
      build_frontend: false

  :test ->
    config :elixre,
      start_http: false,
      build_frontend: false
end
