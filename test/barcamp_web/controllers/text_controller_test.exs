defmodule BarcampWeb.TextControllerTest do
  use BarcampWeb.ConnCase

  alias Barcamp.Content

  @create_attrs %{key: "some key", value_en: "some value_en", value_hy: "some value_hy"}
  @update_attrs %{key: "some updated key", value_en: "some updated value_en", value_hy: "some updated value_hy"}
  @invalid_attrs %{key: nil, value_en: nil, value_hy: nil}

  def fixture(:text) do
    {:ok, text} = Content.create_text(@create_attrs)
    text
  end

  describe "index" do
    test "lists all texts", %{conn: conn} do
      conn = get(conn, Routes.text_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Texts"
    end
  end

  describe "new text" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.text_path(conn, :new))
      assert html_response(conn, 200) =~ "New Text"
    end
  end

  describe "create text" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.text_path(conn, :create), text: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.text_path(conn, :show, id)

      conn = get(conn, Routes.text_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Text"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.text_path(conn, :create), text: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Text"
    end
  end

  describe "edit text" do
    setup [:create_text]

    test "renders form for editing chosen text", %{conn: conn, text: text} do
      conn = get(conn, Routes.text_path(conn, :edit, text))
      assert html_response(conn, 200) =~ "Edit Text"
    end
  end

  describe "update text" do
    setup [:create_text]

    test "redirects when data is valid", %{conn: conn, text: text} do
      conn = put(conn, Routes.text_path(conn, :update, text), text: @update_attrs)
      assert redirected_to(conn) == Routes.text_path(conn, :show, text)

      conn = get(conn, Routes.text_path(conn, :show, text))
      assert html_response(conn, 200) =~ "some updated key"
    end

    test "renders errors when data is invalid", %{conn: conn, text: text} do
      conn = put(conn, Routes.text_path(conn, :update, text), text: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Text"
    end
  end

  describe "delete text" do
    setup [:create_text]

    test "deletes chosen text", %{conn: conn, text: text} do
      conn = delete(conn, Routes.text_path(conn, :delete, text))
      assert redirected_to(conn) == Routes.text_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.text_path(conn, :show, text))
      end
    end
  end

  defp create_text(_) do
    text = fixture(:text)
    {:ok, text: text}
  end
end
