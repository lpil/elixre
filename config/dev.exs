use Mix.Config

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we use it
# with brunch.io to recompile .js and .css sources.
config :elixre, Elixre.Endpoint,
  root: Path.expand("..", __DIR__),
  http: [port: 4000],
  code_reloader: true,
  debug_errors: true,
  cache_static_lookup: false,
  watchers: []
  # watchers: [node: ["node_modules/brunch/bin/brunch", "watch"]]
  # watchers: [node: ["grunt"]]

config :elixre, Elixre.Endpoint,
  live_reload: [
    patterns: [
      ~r{priv/static/.*(js|css)$},
      ~r{web/views/.*(ex)$},
      ~r{web/templates/.*(eex)$}
    ]
  ]

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"
