defmodule Elixre.Mixfile do
  use Mix.Project

  def project do
    [app: :elixre,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: ["lib", "web"],
     compilers: [:phoenix] ++ Mix.compilers,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [
      mod: {Elixre, []},
      applications: applications(Mix.env),
   ]
  end

  defp applications(_) do
    ~w(phoenix cowboy logger)a
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      # Web app framework
      {:phoenix, "~> 1.0"},
      # Our app renders HTML
      {:phoenix_html, "~> 1.0"},
      # Reload web code in development
      {:phoenix_live_reload, "~> 1.0", only: :dev},
      # Web server
      {:cowboy, "~> 1.0"},

      # Test framework
      {:shouldi, "~> 0.2", only: :test},
      # Code linter
      {:dogma, "~> 0.0", only: ~w(dev test)a},
      # Automatically run tests on file changes
      {:mix_test_watch, "~> 0.0", only: :dev},
    ]
  end
end
