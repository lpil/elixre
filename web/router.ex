defmodule Elixre.Router do
  use Phoenix.Router

  pipeline :browser do
    plug :accepts, ["html"]
  end

  pipeline :api do
    plug :accepts, ["json"]
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
