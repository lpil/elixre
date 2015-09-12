defmodule Elixre.Router do
  @moduledoc false

  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ~w(html)
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ~w(json)
  end

  scope "/", Elixre do
    pipe_through :browser
    get "/", PageController, :index
  end

  scope "/", Elixre do
    pipe_through :api
    post "/test", RegexController, :index
  end
end
