defmodule Elixre.PageControllerTest do
  use Elixre.ControllerCase, async: true

  test "/" do
    response = conn(:get, "/") |> send_request

    assert response.status == 200
    assert String.contains?(response.resp_body, "Elixre")
  end
end
