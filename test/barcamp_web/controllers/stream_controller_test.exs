defmodule BarcampWeb.StreamControllerTest do
  use BarcampWeb.ConnCase

  alias Barcamp.Schedule

  @create_attrs %{link: "some link", room: "some room"}
  @update_attrs %{link: "some updated link", room: "some updated room"}
  @invalid_attrs %{link: nil, room: nil}

  def fixture(:stream) do
    {:ok, stream} = Schedule.create_stream(@create_attrs)
    stream
  end

  describe "index" do
    test "lists all streams", %{conn: conn} do
      conn = get conn, Routes.stream_path(conn, :index)
      assert html_response(conn, 200) =~ "Streams"
    end
  end

  describe "new stream" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.stream_path(conn, :new)
      assert html_response(conn, 200) =~ "New Stream"
    end
  end

  describe "create stream" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.stream_path(conn, :create), stream: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.stream_path(conn, :show, id)

      conn = get conn, Routes.stream_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Stream Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.stream_path(conn, :create), stream: @invalid_attrs
      assert html_response(conn, 200) =~ "New Stream"
    end
  end

  describe "edit stream" do
    setup [:create_stream]

    test "renders form for editing chosen stream", %{conn: conn, stream: stream} do
      conn = get conn, Routes.stream_path(conn, :edit, stream)
      assert html_response(conn, 200) =~ "Edit Stream"
    end
  end

  describe "update stream" do
    setup [:create_stream]

    test "redirects when data is valid", %{conn: conn, stream: stream} do
      conn = put conn, Routes.stream_path(conn, :update, stream), stream: @update_attrs
      assert redirected_to(conn) == Routes.stream_path(conn, :show, stream)

      conn = get conn, Routes.stream_path(conn, :show, stream)
      assert html_response(conn, 200) =~ "some updated link"
    end

    test "renders errors when data is invalid", %{conn: conn, stream: stream} do
      conn = put conn, Routes.stream_path(conn, :update, stream), stream: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Stream"
    end
  end

  describe "delete stream" do
    setup [:create_stream]

    test "deletes chosen stream", %{conn: conn, stream: stream} do
      conn = delete conn, Routes.stream_path(conn, :delete, stream)
      assert redirected_to(conn) == Routes.stream_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.stream_path(conn, :show, stream)
      end
    end
  end

  defp create_stream(_) do
    stream = fixture(:stream)
    {:ok, stream: stream}
  end
end
