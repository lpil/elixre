defmodule Elixre.Mixfile do
  use Mix.Project

  def project do
    [app: :elixre,
     version: "0.0.1",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:cowboy, :plug, :logger, :poison]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      # Style linter.
      {:dogma, "~> 0.1", only: [:dev, :test]},
      # Webserver.
      {:cowboy, "~> 1.0.0"},
      # Web app abstracton.
      {:plug, "~> 1.0"},
      # JSON library
      {:poison, "~> 2.0"},
    ]
  end
end
