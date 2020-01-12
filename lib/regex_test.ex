defmodule Elixre.RegexTest do
  @moduledoc false

  def test(pattern, modifiers, subjects) do
    case Regex.compile(pattern, modifiers) do
      {:ok, regex} ->
        %{
          pattern: pattern,
          modifiers: modifiers,
          valid_regex: true,
          results: Enum.map(subjects, &run(regex, &1))
        }

      {:error, reason} ->
        %{
          pattern: pattern,
          modifiers: modifiers,
          valid_regex: false,
          errors: [format_error(reason)]
        }
    end
  end

  defp run(regex, subject) do
    binaries = Regex.run(regex, subject, return: :binary) || []
    indexes = Regex.run(regex, subject, return: :index) || []

    %{
      subject: subject,
      binaries: binaries,
      indexes: Enum.map(indexes, &Tuple.to_list/1)
    }
  end

  defp format_error({error, position}) do
    [to_string(error), position]
  end
end
