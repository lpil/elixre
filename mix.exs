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

  defp applications do
    [:phoenix, :cowboy, :logger]
  end
  defp applications(:test) do
    [:hound] ++ applications
  end
  defp applications(_) do
    applications
  end

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [
      {:phoenix, "~> 0.10.0"},
      {:cowboy, "~> 1.0"},
      {:hound, "~> 0.6.0", only: :test},
      {:shouldi, "~> 0.2.2", only: :test}
    ]
  end
end
