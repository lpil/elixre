defmodule Elixre.Frontend do
  @moduledoc """
  In dev we want our frontend compiled for us. Starting compilers is rubbish,
  so let's do it inside the app.
  """

  use GenServer

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  # Server Callbacks

  def init(:ok) do
    send(self(), :start)

    if Application.get_env(:elixre, :build_frontend) do
      {:ok, []}
    else
      :ignore
    end
  end

  def handle_info(:start, []) do
    IO.puts("Starting Elm compilation watcher...")

    System.cmd(
      "make",
      ["frontend-watch"],
      into: IO.stream(:stdio, :line),
      stderr_to_stdout: true
    )

    {:noreply, []}
  end
end
