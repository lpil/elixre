defmodule Elixre.TestControllerTest do
  use Elixre.ControllerCase, async: true

  import Poison.Parser, only: [parse!: 1]

  @index "/test"

  ############
  #  Params  #
  ############

  test "index errors without subject or regex params" do
    response = conn(:post, @index) |> send_request
    assert response.status == 400
    assert parse!(response.resp_body) == %{
      "error" => %{ "missing params" => ["regex", "subject[]"] }
    }
  end

  test "index errors without subject param" do
    params = %{"regex" => "foo"}
    response = conn(:post, @index, params) |> send_request

    assert response.status == 400
    assert parse!(response.resp_body) == %{
      "error" => %{ "missing params" => ["subject[]"] }
    }
  end

  test "index errors without regex param" do
    params = %{"subject" => "foo"}
    response = conn(:post, @index, params) |> send_request

    assert response.status == 400
    assert parse!(response.resp_body) == %{
      "error" => %{ "missing params" => ["regex"] }
    }
  end

  test "index is 200 with regex and subject params" do
    params = %{"subject" => "foo", "regex" => "foo"}
    response = conn(:post, @index, params) |> send_request

    assert response.status == 200
  end

  ############
  #  Errors  #
  ############

  test "index with invalid regex" do
    params = %{"subject" => "foo", "regex" => "?"}
    response = conn(:post, @index, params) |> send_request

    assert response.status == 200
    assert parse!(response.resp_body) == %{
      "error" => ["nothing to repeat", 0]
    }
  end
end
