defmodule Elixre.PageControllerTest do
  use Elixre.ControllerCase, async: true

  with "/" do
    setup context do
      connection = conn(:get, "/") |> send_request
      Dict.put context, :connection, connection
    end

    should_respond_with :success

    should_match_body_to ~S"An Elixir regular expression editor & tester"

    should_match_body_to ~S"Regex documentation"
    should_match_body_to ~S"re\W+documentation"

    should_match_body_to ~S"Elixre"
    should_match_body_to ~S"Free software"
    should_match_body_to ~S"GNU\W+AGPL3"
    should_match_body_to ~S"GitHub"
    should_match_body_to ~S"Louis Pilfold"
  end
end
