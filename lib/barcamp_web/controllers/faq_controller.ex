defmodule BarcampWeb.FaqController do
  use BarcampWeb, :controller

  alias Barcamp.Content
  alias Barcamp.Content.Faq

  plug(:put_layout, {BarcampWeb.LayoutView, "torch.html"})

  def index(conn, params) do
    case Content.paginate_faqs(params) do
      {:ok, assigns} ->
        render(conn, "index.html", assigns)
      error ->
        conn
        |> put_flash(:error, "There was an error rendering Faqs. #{inspect(error)}")
        |> redirect(to: Routes.faq_path(conn, :index))
    end
  end

  def new(conn, _params) do
    changeset = Content.change_faq(%Faq{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"faq" => faq_params}) do
    case Content.create_faq(faq_params) do
      {:ok, faq} ->
        conn
        |> put_flash(:info, "Faq created successfully.")
        |> redirect(to: Routes.faq_path(conn, :show, faq))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    faq = Content.get_faq!(id)
    render(conn, "show.html", faq: faq)
  end

  def edit(conn, %{"id" => id}) do
    faq = Content.get_faq!(id)
    changeset = Content.change_faq(faq)
    render(conn, "edit.html", faq: faq, changeset: changeset)
  end

  def update(conn, %{"id" => id, "faq" => faq_params}) do
    faq = Content.get_faq!(id)

    case Content.update_faq(faq, faq_params) do
      {:ok, faq} ->
        conn
        |> put_flash(:info, "Faq updated successfully.")
        |> redirect(to: Routes.faq_path(conn, :show, faq))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", faq: faq, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    faq = Content.get_faq!(id)
    {:ok, _faq} = Content.delete_faq(faq)

    conn
    |> put_flash(:info, "Faq deleted successfully.")
    |> redirect(to: Routes.faq_path(conn, :index))
  end
end