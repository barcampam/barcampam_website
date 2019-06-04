defmodule BarcampWeb.SponsorControllerTest do
  use BarcampWeb.ConnCase

  alias Barcamp.Logos

  @create_attrs %{logo: "some logo"}
  @update_attrs %{logo: "some updated logo"}
  @invalid_attrs %{logo: nil}

  def fixture(:sponsor) do
    {:ok, sponsor} = Logos.create_sponsor(@create_attrs)
    sponsor
  end

  describe "index" do
    test "lists all sponsors", %{conn: conn} do
      conn = get conn, Routes.sponsor_path(conn, :index)
      assert html_response(conn, 200) =~ "Sponsors"
    end
  end

  describe "new sponsor" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.sponsor_path(conn, :new)
      assert html_response(conn, 200) =~ "New Sponsor"
    end
  end

  describe "create sponsor" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.sponsor_path(conn, :create), sponsor: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.sponsor_path(conn, :show, id)

      conn = get conn, Routes.sponsor_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Sponsor Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.sponsor_path(conn, :create), sponsor: @invalid_attrs
      assert html_response(conn, 200) =~ "New Sponsor"
    end
  end

  describe "edit sponsor" do
    setup [:create_sponsor]

    test "renders form for editing chosen sponsor", %{conn: conn, sponsor: sponsor} do
      conn = get conn, Routes.sponsor_path(conn, :edit, sponsor)
      assert html_response(conn, 200) =~ "Edit Sponsor"
    end
  end

  describe "update sponsor" do
    setup [:create_sponsor]

    test "redirects when data is valid", %{conn: conn, sponsor: sponsor} do
      conn = put conn, Routes.sponsor_path(conn, :update, sponsor), sponsor: @update_attrs
      assert redirected_to(conn) == Routes.sponsor_path(conn, :show, sponsor)

      conn = get conn, Routes.sponsor_path(conn, :show, sponsor)
      assert html_response(conn, 200)
    end

    test "renders errors when data is invalid", %{conn: conn, sponsor: sponsor} do
      conn = put conn, Routes.sponsor_path(conn, :update, sponsor), sponsor: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Sponsor"
    end
  end

  describe "delete sponsor" do
    setup [:create_sponsor]

    test "deletes chosen sponsor", %{conn: conn, sponsor: sponsor} do
      conn = delete conn, Routes.sponsor_path(conn, :delete, sponsor)
      assert redirected_to(conn) == Routes.sponsor_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.sponsor_path(conn, :show, sponsor)
      end
    end
  end

  defp create_sponsor(_) do
    sponsor = fixture(:sponsor)
    {:ok, sponsor: sponsor}
  end
end
