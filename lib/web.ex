defmodule Elixre.Web do
  use Plug.Router
  alias Elixre.Params
  alias Elixre.RegexTest

  if Mix.env() != :test do
    plug(Plug.Logger)
  end

  plug(Plug.Parsers, parsers: [:json], json_decoder: Poison)
  plug(Plug.NormalizeRootRequests)
  plug(Plug.Static, at: "/", from: "public")
  plug(:match)
  plug(:dispatch)

  @regex_params %{
    pattern: ["regex", "pattern"],
    subjects: ["regex", "subjects"]
  }

  post "/regex" do
    conn = conn |> put_resp_content_type("application/json")

    case Params.get(conn.body_params, @regex_params) do
      {:ok, params} ->
        modifiers = get_in(conn.body_params, ["regex", "modifiers"]) || ""
        result = RegexTest.test(params.pattern, modifiers, params.subjects)
        send_resp(conn, 200, Poison.encode!(%{regex: result}))

      {:missing_params, params} ->
        send_resp(
          conn,
          400,
          Poison.encode!(%{
            errors: %{missing_params: params}
          })
        )
    end
  end

  match _ do
    send_resp(conn, 404, "Page not found")
  end

  def child_spec(_arg) do
    if Application.get_env(:elixre, :start_http) do
      {port, _} = Integer.parse(System.get_env("PORT") || "3000")
      IO.puts("Starting HTTP interface on localhost:#{port}")
      Plug.Cowboy.child_spec(scheme: :http, plug: __MODULE__, options: [port: port])
    else
      %{id: __MODULE__, start: {__MODULE__, :ignore, []}}
    end
  end

  def ignore do
    :ignore
  end
end
