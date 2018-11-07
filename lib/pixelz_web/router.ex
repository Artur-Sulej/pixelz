defmodule PixelzWeb.Router do
  use PixelzWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PixelzWeb.Auth
    plug PixelzWeb.UserToken
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PixelzWeb do
    pipe_through :browser # Use the default browser stack

    get "/boards/*path", BoardController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", PixelzWeb do
  #   pipe_through :api
  # end
end
