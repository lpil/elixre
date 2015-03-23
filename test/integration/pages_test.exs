defmodule HoundTest do
  use ExUnit.Case
  use Hound.Helpers

  hound_session

  # For this to work we need to start PhantomJS beforehand.
  # What's the best way to do this?

  # test "Hound", meta do
  #   navigate_to("http://www.google.com")

  #   assert page_title() == "Google"
  # end
end
