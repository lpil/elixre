defmodule Elixre.PageControllerTest do
  use Elixre.ControllerCase, async: true

  with "/" do
    setup context do
      connection = :get |> conn("/") |> send_request
      Dict.put context, :connection, connection
    end

    should_respond_with :success

    should_match_body_to ~r/An Elixir regular expression editor & tester/

    should_match_body_to ~r/Regex documentation/
    should_match_body_to ~r/re\W+documentation/

    should_match_body_to ~r/Elixre/
    should_match_body_to ~r/Free software/
    should_match_body_to ~r/GNU\W+AGPL3/
    should_match_body_to ~r/GitHub/
    should_match_body_to ~r/Louis Pilfold/
  end
end
