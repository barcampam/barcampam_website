defmodule BarcampWeb.AboutControllerTest do
  use BarcampWeb.ConnCase

  alias Barcamp.Content

  @create_attrs %{text_arm: "some text_arm", text_eng: "some text_eng"}
  @update_attrs %{text_arm: "some updated text_arm", text_eng: "some updated text_eng"}
  @invalid_attrs %{text_arm: nil, text_eng: nil}

  def fixture(:about) do
    {:ok, about} = Content.create_about(@create_attrs)
    about
  end

  describe "index" do
    test "lists all abouts", %{conn: conn} do
      conn = get conn, Routes.about_path(conn, :index)
      assert html_response(conn, 200) =~ "Abouts"
    end
  end

  describe "new about" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.about_path(conn, :new)
      assert html_response(conn, 200) =~ "New About"
    end
  end

  describe "create about" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.about_path(conn, :create), about: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.about_path(conn, :show, id)

      conn = get conn, Routes.about_path(conn, :show, id)
      assert html_response(conn, 200) =~ "About Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.about_path(conn, :create), about: @invalid_attrs
      assert html_response(conn, 200) =~ "New About"
    end
  end

  describe "edit about" do
    setup [:create_about]

    test "renders form for editing chosen about", %{conn: conn, about: about} do
      conn = get conn, Routes.about_path(conn, :edit, about)
      assert html_response(conn, 200) =~ "Edit About"
    end
  end

  describe "update about" do
    setup [:create_about]

    test "redirects when data is valid", %{conn: conn, about: about} do
      conn = put conn, Routes.about_path(conn, :update, about), about: @update_attrs
      assert redirected_to(conn) == Routes.about_path(conn, :show, about)

      conn = get conn, Routes.about_path(conn, :show, about)
      assert html_response(conn, 200) =~ "some updated text_arm"
    end

    test "renders errors when data is invalid", %{conn: conn, about: about} do
      conn = put conn, Routes.about_path(conn, :update, about), about: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit About"
    end
  end

  describe "delete about" do
    setup [:create_about]

    test "deletes chosen about", %{conn: conn, about: about} do
      conn = delete conn, Routes.about_path(conn, :delete, about)
      assert redirected_to(conn) == Routes.about_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.about_path(conn, :show, about)
      end
    end
  end

  defp create_about(_) do
    about = fixture(:about)
    {:ok, about: about}
  end
end
