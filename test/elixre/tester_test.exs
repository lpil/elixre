defmodule Elixre.TesterTest do
  use ExUnit.Case, async: true
  use ShouldI
  import ShouldI.Matchers.Context

  @subject Elixre.Tester

  with "an invalid regex" do
    setup context do
      @subject.test("?", "foo")
    end

    should_not_have_key :results
    should_not_have_key :regex
    should_assign_key error: ["nothing to repeat", 0]
  end


  with "a valid regex" do
    with "one subject" do
      setup context do
        @subject.test("o+(.)?", "foobar")
      end

      should_not_have_key :error
      should_assign_key regex: "~r/o+(.)?/"
      should_assign_key results: [%{subject: "foobar", result: ["oob", "b"]}]
    end

    with "multiple subjects" do
      setup context do
        @subject.test("(?:f|b)(.+)", ["foo", "bar", "baz"])
      end

      should_not_have_key :error
      should_assign_key regex: "~r/(?:f|b)(.+)/"
      should_assign_key results: [
        %{result: ["foo", "oo"], subject: "foo"},
        %{result: ["bar", "ar"], subject: "bar"},
        %{result: ["baz", "az"], subject: "baz"}
      ]
    end


    with "options passed" do
      setup context do
        @subject.test("o+(.)?", "FOOBAR", "i")
      end

      should_not_have_key :error
      should_assign_key regex: "~r/o+(.)?/i"
      should_assign_key results: [%{subject: "FOOBAR", result: ["OOB", "B"]}]
    end


    with "non-string options passed" do
      setup context do
        @subject.test("o+(.)?", "FOOBAR", 123)
      end

      should_not_have_key :results
      should_not_have_key :regex
      should_assign_key error: ["FunctionClauseError. Invalid options", "123"]
    end
  end
end
