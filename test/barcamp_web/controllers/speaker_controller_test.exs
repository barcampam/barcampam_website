defmodule BarcampWeb.SpeakerControllerTest do
  use BarcampWeb.ConnCase

  alias Barcamp.People

  @create_attrs %{bio: "some bio", facebook: "some facebook", instagram: "some instagram", is_special: true, linkedin: "some linkedin", name: "some name", photo: "some photo", topics: "some topics", twitter: "some twitter", website: "some website"}
  @update_attrs %{bio: "some updated bio", facebook: "some updated facebook", instagram: "some updated instagram", is_special: false, linkedin: "some updated linkedin", name: "some updated name", photo: "some updated photo", topics: "some updated topics", twitter: "some updated twitter", website: "some updated website"}
  @invalid_attrs %{bio: nil, facebook: nil, instagram: nil, is_special: nil, linkedin: nil, name: nil, photo: nil, topics: nil, twitter: nil, website: nil}

  def fixture(:speaker) do
    {:ok, speaker} = People.create_speaker(@create_attrs)
    speaker
  end

  describe "index" do
    test "lists all speakers", %{conn: conn} do
      conn = get conn, Routes.speaker_path(conn, :index)
      assert html_response(conn, 200) =~ "Speakers"
    end
  end

  describe "new speaker" do
    test "renders form", %{conn: conn} do
      conn = get conn, Routes.speaker_path(conn, :new)
      assert html_response(conn, 200) =~ "New Speaker"
    end
  end

  describe "create speaker" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post conn, Routes.speaker_path(conn, :create), speaker: @create_attrs

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.speaker_path(conn, :show, id)

      conn = get conn, Routes.speaker_path(conn, :show, id)
      assert html_response(conn, 200) =~ "Speaker Details"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, Routes.speaker_path(conn, :create), speaker: @invalid_attrs
      assert html_response(conn, 200) =~ "New Speaker"
    end
  end

  describe "edit speaker" do
    setup [:create_speaker]

    test "renders form for editing chosen speaker", %{conn: conn, speaker: speaker} do
      conn = get conn, Routes.speaker_path(conn, :edit, speaker)
      assert html_response(conn, 200) =~ "Edit Speaker"
    end
  end

  describe "update speaker" do
    setup [:create_speaker]

    test "redirects when data is valid", %{conn: conn, speaker: speaker} do
      conn = put conn, Routes.speaker_path(conn, :update, speaker), speaker: @update_attrs
      assert redirected_to(conn) == Routes.speaker_path(conn, :show, speaker)

      conn = get conn, Routes.speaker_path(conn, :show, speaker)
      assert html_response(conn, 200) =~ "some updated bio"
    end

    test "renders errors when data is invalid", %{conn: conn, speaker: speaker} do
      conn = put conn, Routes.speaker_path(conn, :update, speaker), speaker: @invalid_attrs
      assert html_response(conn, 200) =~ "Edit Speaker"
    end
  end

  describe "delete speaker" do
    setup [:create_speaker]

    test "deletes chosen speaker", %{conn: conn, speaker: speaker} do
      conn = delete conn, Routes.speaker_path(conn, :delete, speaker)
      assert redirected_to(conn) == Routes.speaker_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, Routes.speaker_path(conn, :show, speaker)
      end
    end
  end

  defp create_speaker(_) do
    speaker = fixture(:speaker)
    {:ok, speaker: speaker}
  end
end
