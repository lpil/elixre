defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  # test "the truth", meta do
  #   navigate_to("http://example.com/guestbook.html")

  #   element_id = find_element(:name, "message")
  #   fill_field(element_id, "Happy Birthday ~!")
  #   submit_element(element_id)

  #   assert page_title() == "Thank you"
  # end
end
