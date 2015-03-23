defmodule Elixre.PageControllerTest do
  use Elixre.ControllerCase, async: true

#   test "/index renders" do
#     contacts_as_json =
#       %Contact{name: "Gumbo", phone: "(801) 555-5555"}
#       |> Repo.insert
#       |> List.wrap
#       |> Poison.encode!

#     response = conn(:get, "/api/contacts") |> send_request

#     assert response.status == 200
#     assert response.resp_body == contacts_as_json
#   end

  test "/" do
    response = conn(:get, "/") |> send_request

    assert response.status == 200
    assert String.contains?(response.resp_body, "Elixre")
  end
end
