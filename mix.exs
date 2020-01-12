defmodule Elixre.Mixfile do
  use Mix.Project

  def project do
    [
      app: :elixre,
      version: "2.0.0",
      elixir: "~> 1.4",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      releases: [
        elixre: [
          include_executables_for: [:unix],
          applications: [runtime_tools: :permanent]
        ]
      ]
    ]
  end

  def application do
    [mod: {Elixre.Application, []}, additional_applications: [:logger]]
  end

  defp deps do
    [
      # Webserver.
      {:cowboy, "~> 2.0"},
      # Web app abstracton.
      {:plug, "~> 1.2"},
      {:plug_cowboy, "~> 2.0"},
      # JSON library
      {:poison, "~> 4.0"}
    ]
  end
end
