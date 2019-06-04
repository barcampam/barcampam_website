defmodule BarcampWeb.SponsorController do
  use BarcampWeb, :controller

  alias Barcamp.Logos
  alias Barcamp.Logos.Sponsor

  plug(:put_layout, {BarcampWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    case Logos.paginate_sponsors(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Sponsors. #{inspect(error)}")
        |> redirect(to: Routes.sponsor_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Logos.change_sponsor(%Sponsor{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sponsor" => sponsor_params}) do
    case Logos.create_sponsor(sponsor_params) do
      {:ok, sponsor} ->
        conn
        |> put_flash(:info, "Sponsor created successfully.")
        |> redirect(to: Routes.sponsor_path(conn, :show, sponsor))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sponsor = Logos.get_sponsor!(id)
    render(conn, "show.html", sponsor: sponsor)
  end

  def edit(conn, %{"id" => id}) do
    sponsor = Logos.get_sponsor!(id)
    changeset = Logos.change_sponsor(sponsor)
    render(conn, "edit.html", sponsor: sponsor, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sponsor" => sponsor_params}) do
    sponsor = Logos.get_sponsor!(id)

    case Logos.update_sponsor(sponsor, sponsor_params) do
      {:ok, sponsor} ->
        conn
        |> put_flash(:info, "Sponsor updated successfully.")
        |> redirect(to: Routes.sponsor_path(conn, :show, sponsor))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", sponsor: sponsor, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sponsor = Logos.get_sponsor!(id)
    {:ok, _sponsor} = Logos.delete_sponsor(sponsor)

    conn
    |> put_flash(:info, "Sponsor deleted successfully.")
    |> redirect(to: Routes.sponsor_path(conn, :index))
  end
end