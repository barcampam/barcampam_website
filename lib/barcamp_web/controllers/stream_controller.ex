defmodule BarcampWeb.StreamController do
  use BarcampWeb, :controller

  alias Barcamp.Schedule
  alias Barcamp.Schedule.Stream

  plug(:put_layout, {BarcampWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    case Schedule.paginate_streams(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Streams. #{inspect(error)}")
        |> redirect(to: Routes.stream_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Schedule.change_stream(%Stream{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stream" => stream_params}) do
    case Schedule.create_stream(stream_params) do
      {:ok, stream} ->
        conn
        |> put_flash(:info, "Stream created successfully.")
        |> redirect(to: Routes.stream_path(conn, :show, stream))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stream = Schedule.get_stream!(id)
    render(conn, "show.html", stream: stream)
  end

  def edit(conn, %{"id" => id}) do
    stream = Schedule.get_stream!(id)
    changeset = Schedule.change_stream(stream)
    render(conn, "edit.html", stream: stream, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stream" => stream_params}) do
    stream = Schedule.get_stream!(id)

    case Schedule.update_stream(stream, stream_params) do
      {:ok, stream} ->
        conn
        |> put_flash(:info, "Stream updated successfully.")
        |> redirect(to: Routes.stream_path(conn, :show, stream))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", stream: stream, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stream = Schedule.get_stream!(id)
    {:ok, _stream} = Schedule.delete_stream(stream)

    conn
    |> put_flash(:info, "Stream deleted successfully.")
    |> redirect(to: Routes.stream_path(conn, :index))
  end
end