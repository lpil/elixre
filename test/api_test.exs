defmodule Elixre.APITest do
  use ExUnit.Case
  use Plug.Test

  @opts Elixre.init []

  defp send_to_api(params) do
    body = Poison.encode!(params)
    :post
    |> conn("/regex", body)
    |> put_req_header("content-type", "application/json")
    |> Elixre.call(@opts)
  end

  test "/regex" do
    conn = send_to_api([1, 2, 3, 4])
    assert conn.status == 200
    assert conn.resp_body == "[4,3,2,1]"
    [header] = get_resp_header(conn, "content-type")
    assert header =~ "application/json"
  end
end
