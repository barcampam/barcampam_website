defmodule BarcampWeb.Router do
  use BarcampWeb, :router
  import BarcampWeb.Auth, only: [authenticate_user: 2]

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_cookies
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BarcampWeb.Auth
  end

  pipeline :locale do
    plug SetLocale, gettext: BarcampWeb.Gettext, default_locale: "en", cookie_key: "_locale"
  end

  scope "/", BarcampWeb do
    pipe_through [:browser, :locale]

    get "/", PageController, :index
    get "/about", PageController, :about
    get "/faq", PageController, :faq

    scope "/:locale" do
      get "/", PageController, :index
      get "/about", PageController, :about
      get "/faq", PageController, :faq
    end
  end

  scope "/admin", BarcampWeb do
    pipe_through :browser

    get "/login", SessionController, :new
    post "/login", SessionController, :create

    scope "/" do
      pipe_through :authenticate_user

      delete "/logout", SessionController, :delete

      resources "/talks", TalkController
      resources "/faqs", FaqController
      resources "/speakers", SpeakerController
      resources "/abouts", AboutController
      resources "/partners", PartnerController
      resources "/generals", GeneralController
      resources "/sponsors", SponsorController
      resources "/streams", StreamController
    end
  end
end
