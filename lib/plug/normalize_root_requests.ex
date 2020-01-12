defmodule Plug.NormalizeRootRequests do
  @moduledoc """
  A plug that normalizes requests to the root path.
  i.e. requests to `"/"` become requests to `"index.html"`

  This is done so that we can serve root requests with `Plug.Static`.
  """

  def init(opts) do
    opts
  end

  def call(%{path_info: []} = conn, _opts) do
    %{conn | path_info: ["index.html"]}
  end

  def call(conn, _opts) do
    conn
  end
end
