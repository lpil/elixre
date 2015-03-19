defmodule RegTest.Tester do
  @doc ~S"""
  Takes a regex in string form, and one or a list of subject strings
  to run the regex on, and returns the results of the test.

  ## Examples

      iex> RegTest.Tester.test(~S".+ (\w+)", "Hello World!")
      %{
        regex: ~S".+ (\w+)",
        results: [
          %{subject: "Hello World!", result: ["Hello World", "World"]}
        ]
      }

      iex> RegTest.Tester.test("foo(.+)", ~w(foobar food foo))
      %{
        regex: "foo(.+)",
        results: [
          %{subject: "foobar", result: ["foobar", "bar"]},
          %{subject: "food",   result: ["food", "d"]},
          %{subject: "foo",    result: nil}
        ]
      }
  """
  def test(regex, subjects) when is_list(subjects) do
    %{
      regex: regex,
      results: Enum.map(subjects, &result(regex, &1))
    }
  end
  def test(regex, subject) do
    test(regex, [subject])
  end

  defp result(regex, subject) do
    {:ok, regex} = Regex.compile(regex)

    %{
      subject: subject,
      result: Regex.run(regex, subject)
    }
  end
end
