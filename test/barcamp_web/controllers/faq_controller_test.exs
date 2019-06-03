defmodule BarcampWeb.FaqControllerTest do
  use BarcampWeb.ConnCase

  alias Barcamp.Content

  @create_attrs %{answer_en: "some answer_en", answer_hy: "some answer_hy", question_en: "some question_en", question_hy: "some question_hy"}
  @update_attrs %{answer_en: "some updated answer_en", answer_hy: "some updated answer_hy", question_en: "some updated question_en", question_hy: "some updated question_hy"}
  @invalid_attrs %{answer_en: nil, answer_hy: nil, question_en: nil, question_hy: nil}

  def fixture(:faq) do
    {:ok, faq} = Content.create_faq(@create_attrs)
    faq
  end

  describe "index" do
    test "lists all faqs", %{conn: conn} do
      conn = get(conn, Routes.faq_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Faqs"
    end
  end

  describe "new faq" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.faq_path(conn, :new))
      assert html_response(conn, 200) =~ "New Faq"
    end
  end

  describe "create faq" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.faq_path(conn, :create), faq: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.faq_path(conn, :show, id)

      conn = get(conn, Routes.faq_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Faq"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.faq_path(conn, :create), faq: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Faq"
    end
  end

  describe "edit faq" do
    setup [:create_faq]

    test "renders form for editing chosen faq", %{conn: conn, faq: faq} do
      conn = get(conn, Routes.faq_path(conn, :edit, faq))
      assert html_response(conn, 200) =~ "Edit Faq"
    end
  end

  describe "update faq" do
    setup [:create_faq]

    test "redirects when data is valid", %{conn: conn, faq: faq} do
      conn = put(conn, Routes.faq_path(conn, :update, faq), faq: @update_attrs)
      assert redirected_to(conn) == Routes.faq_path(conn, :show, faq)

      conn = get(conn, Routes.faq_path(conn, :show, faq))
      assert html_response(conn, 200) =~ "some updated answer_en"
    end

    test "renders errors when data is invalid", %{conn: conn, faq: faq} do
      conn = put(conn, Routes.faq_path(conn, :update, faq), faq: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Faq"
    end
  end

  describe "delete faq" do
    setup [:create_faq]

    test "deletes chosen faq", %{conn: conn, faq: faq} do
      conn = delete(conn, Routes.faq_path(conn, :delete, faq))
      assert redirected_to(conn) == Routes.faq_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.faq_path(conn, :show, faq))
      end
    end
  end

  defp create_faq(_) do
    faq = fixture(:faq)
    {:ok, faq: faq}
  end
end
