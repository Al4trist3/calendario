defmodule CalendarioWeb.Router do
  use CalendarioWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {CalendarioWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", CalendarioWeb do
    pipe_through :browser

    get "/", PageController, :home
    live "/eventos", EventoLive.Index, :index
    live "/eventos/new", EventoLive.Index, :new
    live "/eventos/:id/edit", EventoLive.Index, :edit

    live "/eventos/:id", EventoLive.Show, :show
    live "/eventos/:id/show/edit", EventoLive.Show, :edit

  end

  # Other scopes may use custom stacks.
  # scope "/api", CalendarioWeb do
  #   pipe_through :api
  # end
end
