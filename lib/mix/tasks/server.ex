defmodule Mix.Tasks.Server do
  @moduledoc """
  A mix task to run the Elixre server.
  """
  @shortdoc "Runs the Elixre server"
  use Mix.Task

  def run(_args) do
    {:ok, _} = Plug.Adapters.Cowboy.http(Elixre, [])
    IO.puts """

    Some people, when confronted with a problem, think "I know, I'll use
    regular expressions." Now they have two problems.
      - Jamie Zawinski

    Running Elixre server on port 4000.
    """
    :timer.sleep(:infinity)
  end
end
