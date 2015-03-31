defmodule Elixre.PageControllerTest do
  use Elixre.ControllerCase, async: true

  with "/" do
    setup context do
      connection = conn(:get, "/") |> send_request
      Dict.put context, :connection, connection
    end

    should_respond_with :success
    should_match_body_to "Elixre"
  end
end
