defmodule BarcampWeb.PageController do
  use BarcampWeb, :controller
  alias Barcamp.{Content, Logos, People, Schedule}

  plug :put_locale_cookie

  def index(conn, _assigns) do
    talks =
      if day = conn.params["day"] do
        Enum.filter(Schedule.list_talks(), &(&1.day == String.to_integer(day)))
      else
        Enum.filter(Schedule.list_talks(), &(&1.day == 22))
      end
      |> Enum.sort(&(Time.compare(&1.time_from, &2.time_from) == :lt))

    conn
    |> assign(:talks, talks)
    |> assign(:speakers, People.list_speakers())
    |> assign(:streams, Schedule.list_streams())
    |> assign(:generals, Logos.list_generals())
    |> assign(:sponsors, Logos.list_sponsors())
    |> assign(:partners, Logos.list_partners())
    |> render("index.html")
  end

  def about(conn, _params) do
    abouts =
      if String.contains?(conn.request_path, "am") do
        Enum.map(Content.list_abouts(), & &1.text_arm)
      else
        Enum.map(Content.list_abouts(), & &1.text_eng)
      end

    conn
    |> assign(:abouts, abouts)
    |> assign(:sponsors, Logos.list_sponsors())
    |> assign(:partners, Logos.list_partners())
    |> assign(:generals, Logos.list_generals())
    |> put_layout(:misc)
    |> render("about.html")
  end

  def faq(conn, _params) do
    faqs =
      if String.contains?(conn.request_path, "am") do
        Enum.map(Content.list_faqs(), &%{question: &1.question_arm, answer: &1.answer_arm})
      else
        Enum.map(Content.list_faqs(), &%{question: &1.question_eng, answer: &1.answer_eng})
      end

    conn
    |> assign(:faqs, faqs)
    |> assign(:sponsors, Logos.list_sponsors())
    |> assign(:partners, Logos.list_partners())
    |> assign(:generals, Logos.list_generals())
    |> put_layout(:misc)
    |> render("faq.html")
  end

  defp put_locale_cookie(conn, _opts) do
    put_resp_cookie(conn, "_locale", Gettext.get_locale(BarcampWeb.Gettext))
  end
end
