defmodule BarcampWeb.GeneralController do
  use BarcampWeb, :controller

  alias Barcamp.Logos
  alias Barcamp.Logos.General

  plug(:put_layout, {BarcampWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    case Logos.paginate_generals(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Generals. #{inspect(error)}")
        |> redirect(to: Routes.general_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Logos.change_general(%General{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"general" => general_params}) do
    case Logos.create_general(general_params) do
      {:ok, general} ->
        conn
        |> put_flash(:info, "General created successfully.")
        |> redirect(to: Routes.general_path(conn, :show, general))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    general = Logos.get_general!(id)
    render(conn, "show.html", general: general)
  end

  def edit(conn, %{"id" => id}) do
    general = Logos.get_general!(id)
    changeset = Logos.change_general(general)
    render(conn, "edit.html", general: general, changeset: changeset)
  end

  def update(conn, %{"id" => id, "general" => general_params}) do
    general = Logos.get_general!(id)

    case Logos.update_general(general, general_params) do
      {:ok, general} ->
        conn
        |> put_flash(:info, "General updated successfully.")
        |> redirect(to: Routes.general_path(conn, :show, general))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", general: general, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    general = Logos.get_general!(id)
    {:ok, _general} = Logos.delete_general(general)

    conn
    |> put_flash(:info, "General deleted successfully.")
    |> redirect(to: Routes.general_path(conn, :index))
  end
end