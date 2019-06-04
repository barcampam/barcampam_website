defmodule BarcampWeb.Router do
  use BarcampWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :fetch_cookies
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :locale do
    plug SetLocale, gettext: BarcampWeb.Gettext, default_locale: "en", cookie_key: "_locale"
  end

  pipeline :auth do
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
    pipe_through [:browser, :auth]

    resources "/", SessionController, only: [:new, :create, :delete]
    resources "/talks", TalkController
    resources "/faqs", FaqController
    resources "/speakers", SpeakerController
    resources "/abouts", AboutController
    resources "/partners", PartnerController
    resources "/generals", GeneralController
    resources "/sponsors", SponsorController
  end
end
