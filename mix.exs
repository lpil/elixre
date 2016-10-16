defmodule Elixre.Mixfile do
  use Mix.Project

  def project do
    [app: :elixre,
     version: "2.0.0",
     elixir: "~> 1.3",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [mod: {Elixre, []},
     applications: [:cowboy, :plug, :logger, :poison]]
  end

  defp deps do
    [
      # Style linter.
      {:dogma, "~> 0.1", only: [:dev, :test]},
      # Webserver.
      {:cowboy, "~> 1.0"},
      # Web app abstracton.
      {:plug, "~> 1.2"},
      # JSON library
      {:poison, "~> 3.0"},
    ]
  end
end
