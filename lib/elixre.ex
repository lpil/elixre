defmodule Elixre do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    opts = [strategy: :one_for_one, name: Elixre.Supervisor]
    Supervisor.start_link(children(Mix.env), opts)
  end

  defp children(:dev) do
    [rest_worker()]
  end

  defp children(:prod) do
    [rest_worker()]
  end

  defp children(_) do
    []
  end

  defp rest_worker do
    port = System.get_env("PORT") || 4000
    Plug.Adapters.Cowboy.child_spec(:http, Elixre.REST, [], [port: port])
  end
end
