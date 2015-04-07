defmodule Elixre.Regex do
  @doc ~S"""
  Takes a regex in string form, and one or a list of subject strings
  to run the regex on, and returns the results of the test.

  Regex modifiers can be passed as a third argument.

  If the regex is invalid it is returned with the errors.

  ## Examples

      iex> Elixre.Regex.test(~S".+ (\w+)", "Hello World!")
      %{
        regex: ~S"~r/.+ (\w+)/",
        results: [
          %{subject: "Hello World!", result: ["Hello World", "World"]}
        ]
      }

      iex> Elixre.Regex.test(~S"hello (\w+)", "Hello World!", "i")
      %{
        regex: ~S"~r/hello (\w+)/i",
        results: [
          %{subject: "Hello World!", result: ["Hello World", "World"]}
        ]
      }

      iex> Elixre.Regex.test("foo(.+)", ~w(foobar food foo))
      %{
        regex: ~S"~r/foo(.+)/",
        results: [
          %{subject: "foobar", result: ["foobar", "bar"]},
          %{subject: "food",   result: ["food", "d"]},
          %{subject: "foo",    result: nil}
        ]
      }

      iex> Elixre.Regex.test("*foo", ~w(foobar food foo))
      %{
        error: ["nothing to repeat", 0]
      }
  """
  @spec test(String.t, [String.t], String.t) :: %{}

  def test(regex, subjects, modifiers \\ "")

  def test(regex, subjects, modifiers) when is_binary(modifiers) do
    subjects = List.wrap subjects

    case Regex.compile(regex, modifiers) do
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

  def test(_, _, modifiers) do
    %{
      error: ["FunctionClauseError. Invalid modifiers", inspect(modifiers)]
    }
  end


  @spec result(Regex.t, [String.t]) :: %{}

  defp result(regex, subject) do
    %{
      subject: subject,
      result: Regex.run(regex, subject)
    }
  end
end
