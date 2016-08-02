defmodule Elixre.Frontend do
  @moduledoc """
  In dev we want our frontend compiled for us. Starting compilers is rubbish,
  so let's do it inside the app.
  """

  @cmd_bin "make"
  @cmd_arg ["frontend-server"]
  @cmd_opt [into: IO.stream(:stdio, :line), stderr_to_stdout: true]

  defmodule EnvironmentError do
    @moduledoc false
    defexception message: "The Frontend process should only be started in dev"
  end

  use GenServer

  # Client API

  def start_link do
    GenServer.start_link(__MODULE__, :ok, [])
  end

  # Server Callbacks

  def init(:ok) do
    send self(), :start
    {:ok, []}
  end

  def handle_info(:start, []) do
    IO.puts "Starting front end compiler..."
    if Mix.env != :dev, do: throw EnvironmentError
    System.cmd(@cmd_bin, @cmd_arg, @cmd_opt)
    {:noreply, []}
  end

end
