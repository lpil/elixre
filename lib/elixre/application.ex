defmodule Elixre.Application do
  @moduledoc false
  use Application

  def start(_type, _args) do
    children = [
      Elixre.Web,
      Elixre.Frontend
    ]

    Supervisor.start_link(children, strategy: :one_for_one, name: Elixre.Supervisor)
  end
end
