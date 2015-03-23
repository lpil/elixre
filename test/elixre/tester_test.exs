defmodule Elixre.TesterTest do
  use ExUnit.Case, async: true

  @subject Elixre.Tester

  test ".test with invalid regex" do
    result   = @subject.test("?", "foo")
    expected = %{ error: ["nothing to repeat", 0] }

    assert expected == result
  end

  
  test "index with valid regex and one subject" do
    result   = @subject.test("o+(.)?", "foobar")
    expected = %{
      regex: "~r/o+(.)?/",
      results: [
        %{subject: "foobar", result: ["oob", "b"]}
      ]
    }

    assert expected == result
  end

  test "index with valid regex and multiple subjects" do
    result   = @subject.test("(?:f|b)(.+)", ["foo", "bar", "baz"])
    expected = %{
      regex: "~r/(?:f|b)(.+)/",
      results: [
        %{result: ["foo", "oo"], subject: "foo"},
        %{result: ["bar", "ar"], subject: "bar"},
        %{result: ["baz", "az"], subject: "baz"}
      ]
    }

  assert expected == result
  end
end
