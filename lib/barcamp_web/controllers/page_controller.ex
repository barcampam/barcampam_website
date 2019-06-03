defmodule BarcampWeb.PageController do
  use BarcampWeb, :controller

  plug :put_locale_cookie

  def index(conn, _assigns) do
    render(conn, "index.html")
  end

  def about(conn, _params) do
    render(conn, "about.html")
  end

  def faq(conn, _params) do
    render(conn, "faq.html")
  end

  defp put_locale_cookie(conn, _opts) do
    put_resp_cookie(conn, "_locale", Gettext.get_locale(BarcampWeb.Gettext))
  end
end
