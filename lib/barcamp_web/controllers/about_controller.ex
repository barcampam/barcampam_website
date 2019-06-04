defmodule BarcampWeb.AboutController do
  use BarcampWeb, :controller

  alias Barcamp.Content
  alias Barcamp.Content.About

  plug(:put_layout, {BarcampWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    case Content.paginate_abouts(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Abouts. #{inspect(error)}")
        |> redirect(to: Routes.about_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Content.change_about(%About{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"about" => about_params}) do
    case Content.create_about(about_params) do
      {:ok, about} ->
        conn
        |> put_flash(:info, "About created successfully.")
        |> redirect(to: Routes.about_path(conn, :show, about))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    about = Content.get_about!(id)
    render(conn, "show.html", about: about)
  end

  def edit(conn, %{"id" => id}) do
    about = Content.get_about!(id)
    changeset = Content.change_about(about)
    render(conn, "edit.html", about: about, changeset: changeset)
  end

  def update(conn, %{"id" => id, "about" => about_params}) do
    about = Content.get_about!(id)

    case Content.update_about(about, about_params) do
      {:ok, about} ->
        conn
        |> put_flash(:info, "About updated successfully.")
        |> redirect(to: Routes.about_path(conn, :show, about))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", about: about, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    about = Content.get_about!(id)
    {:ok, _about} = Content.delete_about(about)

    conn
    |> put_flash(:info, "About deleted successfully.")
    |> redirect(to: Routes.about_path(conn, :index))
  end
end