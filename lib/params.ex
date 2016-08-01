defmodule Elixre.Params do
  @moduledoc """
  Pulling params out of nested maps.
  """

  @doc """
  The params schema is described like so:
      %{ variable_name: ["path", "to", "value"] }

  e.g.

      %{
        pattern: ["regex", "pattern"],
        subjects: ["regex", "subjects"],
      }
  """
  def get(data, schema) do
    schema
    |> Enum.reduce({%{}, []}, &reduce_params(data, &1, &2))
    |> case do
      {params, []} ->
        {:ok, params}

      {_, missing_params} ->
        {:missing_params, missing_params}
    end
  end

  defp reduce_params(data, {label, pattern}, {params, missing_params}) do
    case get_in(data, pattern) do
      nil ->
        {params, [Enum.join(pattern, ".") | missing_params]}
      value ->
        {Map.put(params, label, value), missing_params}
    end
  end
end
