defmodule RegTest.TestView do
  use RegTest.Web, :view

  def render("result.json", %{data: data}) do
    data
  end
end
