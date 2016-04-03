defmodule ElixreTest do
  use ExUnit.Case
  use Plug.Test
  doctest Elixre

  @opts Elixre.init []

  test "test home route" do
    conn =
      :get
      |> conn("/")
      |> Elixre.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body =~ "Elixre"
    assert conn.resp_body =~ "<head>"
  end

  test "unknown route" do
    conn =
      :get
      |> conn("/no-dinosaurs-EVER")
      |> Elixre.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "Page not found"
  end
end
