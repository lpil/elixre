defmodule Elixre.ControllerCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use Plug.Test

      defp send_request(conn) do
        conn
        |> put_private(:plug_skip_csrf_protection, true)
        |> Elixre.Endpoint.call([])
      end
    end
  end
end

ExUnit.start
