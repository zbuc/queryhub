defmodule QueryhubWeb.Router do
  use QueryhubWeb, :router

  pipeline :browser do
    plug(:accepts, ["html"])
    plug(:fetch_session)
    plug(:fetch_flash)
    plug(:protect_from_forgery)
    plug(:put_secure_browser_headers)
  end

  pipeline :api do
    plug(:accepts, ["json"])
  end

  scope "/", QueryhubWeb do
    # Use the default browser stack
    pipe_through(:browser)

    get("/", PageController, :index)
    get("/queries", QueryController, :index)
    get("/queries/new", QueryController, :new)
    get("/queries/create", QueryController, :create)
    get("/queries/edit", QueryController, :edit)
    get("/queries/update", QueryController, :update)
    get("/queries/delete", QueryController, :delete)
  end

  # Other scopes may use custom stacks.
  # scope "/api", QueryhubWeb do
  #   pipe_through :api
  # end
end
