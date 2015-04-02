defmodule Elixre.Tester do
  @doc ~S"""
  Takes a regex in string form, and one or a list of subject strings
  to run the regex on, and returns the results of the test.

  Regex options can be passed as a third argument.

  If the regex is invalid it is returned with the errors.

  ## Examples

      iex> Elixre.Tester.test(~S".+ (\w+)", "Hello World!")
      %{
        regex: ~S"~r/.+ (\w+)/",
        results: [
          %{subject: "Hello World!", result: ["Hello World", "World"]}
        ]
      }

      iex> Elixre.Tester.test(~S"hello (\w+)", "Hello World!", "i")
      %{
        regex: ~S"~r/hello (\w+)/i",
        results: [
          %{subject: "Hello World!", result: ["Hello World", "World"]}
        ]
      }

      iex> Elixre.Tester.test("foo(.+)", ~w(foobar food foo))
      %{
        regex: ~S"~r/foo(.+)/",
        results: [
          %{subject: "foobar", result: ["foobar", "bar"]},
          %{subject: "food",   result: ["food", "d"]},
          %{subject: "foo",    result: nil}
        ]
      }

      iex> Elixre.Tester.test("*foo", ~w(foobar food foo))
      %{
        error: ["nothing to repeat", 0]
      }
  """
  def test(regex, subjects, options \\ "")

  def test(regex, subjects, options) when is_binary(options) do
    subjects = List.wrap subjects

    case Regex.compile(regex, options) do
      {:ok, regex} ->
        %{
          regex: inspect(regex),
          results: Enum.map(subjects, &result(regex, &1))
        }

      {:error, {error, pos}} ->
        %{
          error: [to_string(error), pos]
        }
    end
  end

  def test(_, _, options) do
    %{
      error: ["FunctionClauseError. Invalid options", inspect(options)]
    }
  end

  defp result(regex, subject) do
    %{
      subject: subject,
      result: Regex.run(regex, subject)
    }
  end
end
