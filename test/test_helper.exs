defmodule Elixre.ControllerCase do
  use ExUnit.CaseTemplate
  using do
    quote do
      use Plug.Test
      use ShouldI
      import ShouldI.Matchers.Plug
      import ShouldI.Matchers.PlugApi
      import ShouldI.Matchers.Context

      defp send_request(conn) do
        conn
        |> put_private(:plug_skip_csrf_protection, true)
        |> Elixre.Endpoint.call([])
      end
    end
  end
end

ExUnit.start(formatters: [ShouldI.CLIFormatter])


defmodule ShouldI.Matchers.PlugApi do

  import ExUnit.Assertions
  import ShouldI.Matcher

  defmatcher should_return_json_of(json) do
    quote do
      resp_body = var!(context).connection.resp_body
      assert Poison.Parser.parse!(resp_body) == unquote(json)
    end
  end
end
