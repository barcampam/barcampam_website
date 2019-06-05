defmodule BarcampWeb.SessionController do
  use BarcampWeb, :controller
  alias BarcampWeb.Auth

  plug(:put_layout, false)

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn, %{"session" => %{"login" => login, "password" => password}}) do
    case Auth.check_credentials(conn, login, password) do
      {:ok, conn} ->
        conn
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.speaker_path(conn, :index))

      {:error, _reason, conn} ->
        conn
        |> put_flash(:error, "Invalid credentials")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> Auth.logout()
    |> redirect(to: Routes.session_path(conn, :new))
  end
end
