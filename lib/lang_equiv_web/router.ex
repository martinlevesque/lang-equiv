defmodule LangEquivWeb.Router do
  use LangEquivWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {LangEquivWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers

  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", LangEquivWeb do
    pipe_through :browser

    live "/", HomeLive, :index

  end

  scope "/admin/", LangEquivWeb do
    pipe_through :browser

    # how tos
    live "/how_tos", HowToLive.Index, :index
    live "/how_tos/new", HowToLive.Index, :new
    live "/how_tos/:id/edit", HowToLive.Index, :edit

    live "/how_tos/:id", HowToLive.Show, :show
    live "/how_tos/:id/show/edit", HowToLive.Show, :edit

    # technology categories
    live "/technology_categories", TechnologyCategoryLive.Index, :index
    live "/technology_categories/new", TechnologyCategoryLive.Index, :new
    live "/technology_categories/:id/edit", TechnologyCategoryLive.Index, :edit

    live "/technology_categories/:id", TechnologyCategoryLive.Show, :show
    live "/technology_categories/:id/show/edit", TechnologyCategoryLive.Show, :edit

    # technologies
    live "/technologies", TechnologyLive.Index, :index
    live "/technologies/new", TechnologyLive.Index, :new
    live "/technologies/:id/edit", TechnologyLive.Index, :edit

    live "/technologies/:id", TechnologyLive.Show, :show
    live "/technologies/:id/show/edit", TechnologyLive.Show, :edit

    # snippets
    live "/snippets", SnippetLive.Index, :index
    live "/snippets/new", SnippetLive.Index, :new
    live "/snippets/:id/edit", SnippetLive.Index, :edit

    live "/snippets/:id", SnippetLive.Show, :show
    live "/snippets/:id/show/edit", SnippetLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", LangEquivWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser
      live_dashboard "/dashboard", metrics: LangEquivWeb.Telemetry
    end
  end
end
