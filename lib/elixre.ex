defmodule Elixre do
  @moduledoc false
  use Application
  import Supervisor.Spec

  def start(_type, _args) do
    opts = [strategy: :one_for_one, name: Elixre.Supervisor]
    Supervisor.start_link(children(Mix.env), opts)
  end

  defp children(:dev) do
    [rest_worker(),
     worker(Elixre.Frontend, [])]
  end

  defp children(:prod) do
    [rest_worker()]
  end

  defp children(_) do
    []
  end

  defp rest_worker do
    {port, _} = "PORT" |> System.get_env() |> Integer.parse()
    port = port || 4000
    Plug.Adapters.Cowboy.child_spec(:http, Elixre.REST, [], [port: port])
  end
end
