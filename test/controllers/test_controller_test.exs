defmodule Elixre.TestControllerTest do
  use Elixre.ControllerCase, async: true

  import Poison.Parser, only: [parse!: 1]

  test "/test errors without subject or regex params" do
    response = conn(:post, "/test") |> send_request
    assert response.status == 400
    assert parse!(response.resp_body) == %{
      "error" => %{ "missing params" => ["regex", "subject[]"] }
    }
  end

  test "/test errors without subject param" do
    params = %{"regex" => "foo"}
    response = conn(:post, "/test", params) |> send_request

    assert response.status == 400
    assert parse!(response.resp_body) == %{
      "error" => %{ "missing params" => ["subject[]"] }
    }
  end

  test "/test errors without regex param" do
    params = %{"subject" => "foo"}
    response = conn(:post, "/test", params) |> send_request

    assert response.status == 400
    assert parse!(response.resp_body) == %{
      "error" => %{ "missing params" => ["regex"] }
    }
  end
end
