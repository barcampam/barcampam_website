defmodule BarcampWeb.FaqControllerTest do
  use BarcampWeb.ConnCase

  alias Barcamp.Content

  @create_attrs %{answer_arm: "some answer_arm", answer_eng: "some answer_eng", question_arm: "some question_arm", question_eng: "some question_eng"}
  @update_attrs %{answer_arm: "some updated answer_arm", answer_eng: "some updated answer_eng", question_arm: "some updated question_arm", question_eng: "some updated question_eng"}
  @invalid_attrs %{answer_arm: nil, answer_eng: nil, question_arm: nil, question_eng: nil}

  def fixture(:faq) do
    {:ok, faq} = Content.create_faq(@create_attrs)
    faq
  end

  describe "index" do
    test "lists all faqs", %{conn: conn} do
      conn = get conn, Routes.faq_path(conn, :index)
      assert html_response(conn, 200) =~ "Faqs"
    end
  end

  describe "new faq" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.faq_path(conn, :new)
      assert html_response(conn, 200) =~ "New Faq"
    end
  end

  describe "create faq" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.faq_path(conn, :create), faq: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.faq_path(conn, :show, id)

      conn = get conn, Routes.faq_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Faq Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.faq_path(conn, :create), faq: @invalid_attrs
      assert html_response(conn, 200) =~ "New Faq"
    end
  end

  describe "edit faq" do
    setup [:create_faq]

    test "renders form for editing chosen faq", %{conn: conn, faq: faq} do
      conn = get conn, Routes.faq_path(conn, :edit, faq)
      assert html_response(conn, 200) =~ "Edit Faq"
    end
  end

  describe "update faq" do
    setup [:create_faq]

    test "redirects when data is valid", %{conn: conn, faq: faq} do
      conn = put conn, Routes.faq_path(conn, :update, faq), faq: @update_attrs
      assert redirected_to(conn) == Routes.faq_path(conn, :show, faq)

      conn = get conn, Routes.faq_path(conn, :show, faq)
      assert html_response(conn, 200) =~ "some updated answer_arm"
    end

    test "renders errors when data is invalid", %{conn: conn, faq: faq} do
      conn = put conn, Routes.faq_path(conn, :update, faq), faq: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Faq"
    end
  end

  describe "delete faq" do
    setup [:create_faq]

    test "deletes chosen faq", %{conn: conn, faq: faq} do
      conn = delete conn, Routes.faq_path(conn, :delete, faq)
      assert redirected_to(conn) == Routes.faq_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.faq_path(conn, :show, faq)
      end
    end
  end

  defp create_faq(_) do
    faq = fixture(:faq)
    {:ok, faq: faq}
  end
end
