defmodule BarcampWeb.SpeakerController do
  use BarcampWeb, :controller

  alias Barcamp.People
  alias Barcamp.People.Speaker

  plug(:put_layout, {BarcampWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    case People.paginate_speakers(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Speakers. #{inspect(error)}")
        |> redirect(to: Routes.speaker_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = People.change_speaker(%Speaker{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"speaker" => speaker_params}) do
    case People.create_speaker(speaker_params) do
      {:ok, speaker} ->
        conn
        |> put_flash(:info, "Speaker created successfully.")
        |> redirect(to: Routes.speaker_path(conn, :show, speaker))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    speaker = People.get_speaker!(id)
    render(conn, "show.html", speaker: speaker)
  end

  def edit(conn, %{"id" => id}) do
    speaker = People.get_speaker!(id)
    changeset = People.change_speaker(speaker)
    render(conn, "edit.html", speaker: speaker, changeset: changeset)
  end

  def update(conn, %{"id" => id, "speaker" => speaker_params}) do
    speaker = People.get_speaker!(id)

    case People.update_speaker(speaker, speaker_params) do
      {:ok, speaker} ->
        conn
        |> put_flash(:info, "Speaker updated successfully.")
        |> redirect(to: Routes.speaker_path(conn, :show, speaker))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", speaker: speaker, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    speaker = People.get_speaker!(id)
    {:ok, _speaker} = People.delete_speaker(speaker)

    conn
    |> put_flash(:info, "Speaker deleted successfully.")
    |> redirect(to: Routes.speaker_path(conn, :index))
  end
end