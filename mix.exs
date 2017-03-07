defmodule Elixre.Mixfile do
  use Mix.Project

  def project do
    [app: :elixre,
     version: "2.0.0",
     elixir: "~> 1.4",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  def application do
    [mod: {Elixre, []},
     additional_applications: [:logger]]
  end

  defp deps do
    [
      # Webserver.
      {:cowboy, "~> 1.0"},
      # Web app abstracton.
      {:plug, "~> 1.2"},
      # JSON library
      {:poison, "~> 3.0"},
      # CORS request middleware
      {:corsica, "~> 0.5"}
    ]
  end
end
