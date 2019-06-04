defmodule BarcampWeb.GeneralControllerTest do
  use BarcampWeb.ConnCase

  alias Barcamp.Logos

  @create_attrs %{logo: "some logo"}
  @update_attrs %{logo: "some updated logo"}
  @invalid_attrs %{logo: nil}

  def fixture(:general) do
    {:ok, general} = Logos.create_general(@create_attrs)
    general
  end

  describe "index" do
    test "lists all generals", %{conn: conn} do
      conn = get conn, Routes.general_path(conn, :index)
      assert html_response(conn, 200) =~ "Generals"
    end
  end

  describe "new general" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.general_path(conn, :new)
      assert html_response(conn, 200) =~ "New General"
    end
  end

  describe "create general" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.general_path(conn, :create), general: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.general_path(conn, :show, id)

      conn = get conn, Routes.general_path(conn, :show, id)
      assert html_response(conn, 200) =~ "General Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.general_path(conn, :create), general: @invalid_attrs
      assert html_response(conn, 200) =~ "New General"
    end
  end

  describe "edit general" do
    setup [:create_general]

    test "renders form for editing chosen general", %{conn: conn, general: general} do
      conn = get conn, Routes.general_path(conn, :edit, general)
      assert html_response(conn, 200) =~ "Edit General"
    end
  end

  describe "update general" do
    setup [:create_general]

    test "redirects when data is valid", %{conn: conn, general: general} do
      conn = put conn, Routes.general_path(conn, :update, general), general: @update_attrs
      assert redirected_to(conn) == Routes.general_path(conn, :show, general)

      conn = get conn, Routes.general_path(conn, :show, general)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, general: general} do
      conn = put conn, Routes.general_path(conn, :update, general), general: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit General"
    end
  end

  describe "delete general" do
    setup [:create_general]

    test "deletes chosen general", %{conn: conn, general: general} do
      conn = delete conn, Routes.general_path(conn, :delete, general)
      assert redirected_to(conn) == Routes.general_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.general_path(conn, :show, general)
      end
    end
  end

  defp create_general(_) do
    general = fixture(:general)
    {:ok, general: general}
  end
end
