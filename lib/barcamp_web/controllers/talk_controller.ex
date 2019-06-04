defmodule BarcampWeb.TalkController do
  use BarcampWeb, :controller

  alias Barcamp.Schedule
  alias Barcamp.Schedule.Talk

  plug(:put_layout, {BarcampWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    case Schedule.paginate_talks(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Talks. #{inspect(error)}")
        |> redirect(to: Routes.talk_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Schedule.change_talk(%Talk{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"talk" => talk_params}) do
    case Schedule.create_talk(talk_params) do
      {:ok, talk} ->
        conn
        |> put_flash(:info, "Talk created successfully.")
        |> redirect(to: Routes.talk_path(conn, :show, talk))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    talk = Schedule.get_talk!(id)
    render(conn, "show.html", talk: talk)
  end

  def edit(conn, %{"id" => id}) do
    talk = Schedule.get_talk!(id)
    changeset = Schedule.change_talk(talk)
    render(conn, "edit.html", talk: talk, changeset: changeset)
  end

  def update(conn, %{"id" => id, "talk" => talk_params}) do
    talk = Schedule.get_talk!(id)

    case Schedule.update_talk(talk, talk_params) do
      {:ok, talk} ->
        conn
        |> put_flash(:info, "Talk updated successfully.")
        |> redirect(to: Routes.talk_path(conn, :show, talk))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", talk: talk, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    talk = Schedule.get_talk!(id)
    {:ok, _talk} = Schedule.delete_talk(talk)

    conn
    |> put_flash(:info, "Talk deleted successfully.")
    |> redirect(to: Routes.talk_path(conn, :index))
  end
end