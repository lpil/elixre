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
    [mod: {Elixre, []},
     applications: applications(Mix.env)]
  end

  defp applications(_) do
    [:phoenix, :cowboy, :logger]
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 0.13.1"},
      {:phoenix_html, "~> 1.0"},
      {:phoenix_live_reload, "~> 0.4", only: :dev},
      {:cowboy, "~> 1.0"},
      {:shouldi, "~> 0.2.2", only: :test}
    ]
  end
end
