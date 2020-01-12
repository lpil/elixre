defmodule Elixre do
  @moduledoc false
  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Elixre.Supervisor]
    Supervisor.start_link(children(Mix.env()), opts)
  end

  defp children(:dev) do
    {port, _} = Integer.parse(System.get_env("PORT") || "4000")

    [
      {Plug.Cowboy, scheme: :http, plug: Elixre.REST, options: [port: port]},
      Elixre.Frontend
    ]
  end
end
