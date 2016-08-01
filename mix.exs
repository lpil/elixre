defmodule Elixre.Mixfile do
  use Mix.Project

  def project do
    [app: :elixre,
     version: "2.0.0",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:cowboy, :plug, :logger, :poison,]]
  end

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
