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
          %{
            subject: "Hello World!",
            result: ["Hello World", "World"],
            indexes: [[0, 11], [6, 5]]
          }
        ]
      }

      iex> Elixre.Regex.test(~S"hello (\w+)", "Hello World!", "i")
      %{
        regex: ~S"~r/hello (\w+)/i",
        results: [
          %{
            subject: "Hello World!",
            result: ["Hello World", "World"],
            indexes: [[0, 11], [6, 5]]
          }
        ]
      }

      iex> Elixre.Regex.test("foo(.+)", ~w(food foo))
      %{
        regex: ~S"~r/foo(.+)/",
        results: [
          %{subject: "food", result: ["food", "d"], indexes: [[0, 4], [3, 1]]},
          %{subject: "foo", result: nil, indexes: nil}
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
          results: Enum.map(subjects, &results(regex, &1))
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

  defp results(regex, subject) do
    %{
      subject: subject,
      result:  result(regex, subject),
      indexes: indexes(regex, subject),
    }
  end

  defp result(regex, subject) do
    Regex.run(regex, subject, return: :binary)
  end

  defp indexes(regex, subject) do
    result = Regex.run(regex, subject, return: :index)
    if result do
      Enum.map result, &Tuple.to_list(&1)
    else
      result
    end
  end
end
