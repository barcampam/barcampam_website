defmodule BarcampWeb.TalkControllerTest do
  use BarcampWeb.ConnCase

  alias Barcamp.Speakers

  @create_attrs %{description: "some description", room: "some room", speaker: "some speaker", time_from: ~N[2010-04-17 14:00:00], time_to: ~N[2010-04-17 14:00:00], topics: "some topics"}
  @update_attrs %{description: "some updated description", room: "some updated room", speaker: "some updated speaker", time_from: ~N[2011-05-18 15:01:01], time_to: ~N[2011-05-18 15:01:01], topics: "some updated topics"}
  @invalid_attrs %{description: nil, room: nil, speaker: nil, time_from: nil, time_to: nil, topics: nil}

  def fixture(:talk) do
    {:ok, talk} = Speakers.create_talk(@create_attrs)
    talk
  end

  describe "index" do
    test "lists all talks", %{conn: conn} do
      conn = get(conn, Routes.talk_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Talks"
    end
  end

  describe "new talk" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.talk_path(conn, :new))
      assert html_response(conn, 200) =~ "New Talk"
    end
  end

  describe "create talk" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.talk_path(conn, :create), talk: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.talk_path(conn, :show, id)

      conn = get(conn, Routes.talk_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Talk"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.talk_path(conn, :create), talk: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Talk"
    end
  end

  describe "edit talk" do
    setup [:create_talk]

    test "renders form for editing chosen talk", %{conn: conn, talk: talk} do
      conn = get(conn, Routes.talk_path(conn, :edit, talk))
      assert html_response(conn, 200) =~ "Edit Talk"
    end
  end

  describe "update talk" do
    setup [:create_talk]

    test "redirects when data is valid", %{conn: conn, talk: talk} do
      conn = put(conn, Routes.talk_path(conn, :update, talk), talk: @update_attrs)
      assert redirected_to(conn) == Routes.talk_path(conn, :show, talk)

      conn = get(conn, Routes.talk_path(conn, :show, talk))
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, talk: talk} do
      conn = put(conn, Routes.talk_path(conn, :update, talk), talk: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Talk"
    end
  end

  describe "delete talk" do
    setup [:create_talk]

    test "deletes chosen talk", %{conn: conn, talk: talk} do
      conn = delete(conn, Routes.talk_path(conn, :delete, talk))
      assert redirected_to(conn) == Routes.talk_path(conn, :index)
      assert_error_sent 404, fn ->
        get(conn, Routes.talk_path(conn, :show, talk))
      end
    end
  end

  defp create_talk(_) do
    talk = fixture(:talk)
    {:ok, talk: talk}
  end
end
