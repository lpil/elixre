defmodule RegTest.TestController do
  use RegTest.Web, :controller

  import RegTest.Tester, only: [test: 2]

  plug :action

  def index(conn, %{"regex" => regex, "subject" => subject}) do
    render conn, "result.json", data: test(regex, subject)
  end

  def index(conn, params) do
    conn
    |> put_status(400)
    |> render "result.json", data: %{error: missing(params)}
  end


  defp missing(params) do
    params = params
    |> Dict.keys
    |> Enum.filter(&(&1 == "regex" or &1 == "subject"))
    |> case do
      ~w(regex)   -> ~w(subject[])
      ~w(subject) -> ~w(regex)
      _           -> ~w(regex subject[])
    end

    %{"missing params": params}
  end
end
