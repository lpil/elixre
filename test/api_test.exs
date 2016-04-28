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

  defp assert_body(conn, data) do
    body = conn.resp_body |> Poison.decode!
    expected = data |> Poison.encode!
    assert body == expected
  end

  defp assert_header(conn, header, pattern) do
    header = conn |> get_resp_header(header) |> hd
    assert header =~ pattern
  end


  @tag :skip
  test "a valid request" do
    conn = send_to_api(%{
      regex: %{
        pattern: "foo",
        modifiers: "iu",
        subjects: ["foobarfoo", "FOOBAR", "barfoo"],
      },
    })
    assert conn.status == 200
    assert_header(conn, "content-type", "application/json")
    assert_body(conn, %{
      regex: %{
        pattern: "^foo",
        modifiers: "iu",
        results: [
          %{ subject: "foobar" },
          %{ subject: "FOOBAR" },
          %{ subject: "barfoo" },
        ],
      },
    })
  end

  @tag :skip
  test "a valid request (no modifiers param)" do
    conn = send_to_api(%{
      regex: %{
        pattern: "foo",
        subjects: ["foobarfoo", "barfoo"],
      },
    })
    assert conn.status == 200
    assert_body(conn, %{
      regex: %{
        pattern: "^foo",
        modifiers: "",
        results: [
          %{ subject: "foobar" },
          %{ subject: "barfoo" },
        ],
      },
    })
  end

  @tag :skip
  test "a valid request (no subjects param)" do
    conn = send_to_api(%{
      regex: %{
        pattern: "foo",
        modifiers: "i",
      },
    })
    assert conn.status == 200
    assert_body(conn, %{
      regex: %{
        pattern: "^foo",
        modifiers: "",
        results: [],
      },
    })
  end

  @tag :skip
  test "missing `pattern` param" do
    conn = send_to_api(%{
      regex: %{
        modifiers: "iu",
        subjects: ["foobarfoo", "FOOBAR", "barfoo"],
      },
    })
    assert conn.status == 400
    assert_body(conn, %{
      errors: ["`pattern` parameter must be present"],
    })
  end
end
