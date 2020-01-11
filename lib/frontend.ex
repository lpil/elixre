defmodule Elixre.Frontend do
  @moduledoc """
  In dev we want our frontend compiled for us. Starting compilers is rubbish,
  so let's do it inside the app.
  """

  @cmd_bin "make"
  @cmd_arg ["frontend-server"]
  @cmd_opt [into: IO.stream(:stdio, :line), stderr_to_stdout: true]

  use GenServer

  # Client API

  def start_link(_) do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  # Server Callbacks

  def init(:ok) do
    send(self(), :start)

    case Mix.env() do
      :dev -> {:ok, []}
      _ -> :ignore
    end
  end

  def handle_info(:start, []) do
    IO.puts("Starting front end compiler...")
    System.cmd(@cmd_bin, @cmd_arg, @cmd_opt)
    {:noreply, []}
  end
end
