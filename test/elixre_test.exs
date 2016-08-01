defmodule ElixreTest do
  use ExUnit.Case
  use Plug.Test
  doctest Elixre

  @opts Elixre.init []

  defp post_regex(body) do
    conn = :post
      |> conn("/regex", Poison.encode!(body))
      |> put_req_header("content-type", "application/json")
      |> Elixre.call(@opts)
    assert conn.state == :sent
    conn
  end

  test "Home page renders OK" do
    conn =
      :get
      |> conn("/")
      |> Elixre.call(@opts)
    assert conn.state == :sent
    assert conn.status == 200
    assert conn.resp_body =~ "Elixre"
  end

  test "unknown routes 404" do
    conn =
      :get
      |> conn("/no-dinosaurs-EVER")
      |> Elixre.call(@opts)
    assert conn.state == :sent
    assert conn.status == 404
    assert conn.resp_body == "Page not found"
  end

  describe "/regex" do
    test "request missing pattern and subjects" do
      conn = post_regex(%{
        regex: %{
        },
      })
      assert conn.status == 400
      body = conn.resp_body |> Poison.decode!
      assert body == %{
        "errors" => %{
          "missing_params" => [
            "regex.subjects",
            "regex.pattern",
          ],
        },
      }
    end

    @tag :skip
    test "valid request with modifiers" do
      conn = post_regex(%{
        regex: %{
          pattern: "foo",
          modifiers: "iu",
          subjects: [
            "foobarfoo",
            "FOOBAR",
            "barfoo",
          ],
        },
      })
      assert conn.status == 200
      body = conn.resp_body |> Poison.decode!
      assert body == %{
        "regex" => %{
          "pattern" => "^foo",
          "modifiers" => "iu",
          "valid_regex" => true,
          "results" => [
            %{
              "subject" => "foobar",
              "binaries" => ["foo"],
              "indexes" => [[0, 3]]
            },
            %{
              "subject" => "FOOBAR",
              "binaries" => ["FOO"],
              "indexes" => [[0, 3]]
            },
            %{
              "subject" => "barfoo",
              "binaries" => [],
              "indexes" => []
            },
          ],
        },
      }
    end
  end
end
