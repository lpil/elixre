defmodule Elixre do
  @moduledoc false
  use Application

  def start(_type, _args) do
    {port, _} = Integer.parse(System.get_env("PORT") || "3000")

    children = [
      {Plug.Cowboy, scheme: :http, plug: Elixre.REST, options: [port: port]},
      Elixre.Frontend
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Elixre.Supervisor)
  end
end
