defmodule BarcampWeb.Router do
  use BarcampWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :put_secure_browser_headers
    plug :fetch_cookies
    plug SetLocale, gettext: BarcampWeb.Gettext, default_locale: "en", cookie_key: "_locale"
  end

  scope "/", BarcampWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/faq", PageController, :faq
  end

  scope "/:locale", BarcampWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/faq", PageController, :faq
  end
end
