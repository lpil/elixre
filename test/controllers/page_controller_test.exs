defmodule Elixre.PageControllerTest do
  use ExUnit.Case, async: true
  use Plug.Test

  test "/" do
    response = conn(:get, "/") |> send_request

    assert response.status == 200
    assert String.contains?(response.resp_body, "Elixre")
  end


  defp send_request(conn) do
    conn
    |> put_private(:plug_skip_csrf_protection, true)
    |> Elixre.Endpoint.call([])
  end
end
