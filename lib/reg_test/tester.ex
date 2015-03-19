defmodule RegTest.Tester do
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
