defmodule Barcamp.ScheduleTest do
  use Barcamp.DataCase

  alias Barcamp.Schedule

  describe "talks" do
    alias Barcamp.Schedule.Talk

    @valid_attrs %{description: "some description", room: "some room", time_from: ~N[2010-04-17 14:00:00], time_to: ~N[2010-04-17 14:00:00], title: "some title"}
    @update_attrs %{description: "some updated description", room: "some updated room", time_from: ~N[2011-05-18 15:01:01], time_to: ~N[2011-05-18 15:01:01], title: "some updated title"}
    @invalid_attrs %{description: nil, room: nil, time_from: nil, time_to: nil, title: nil}

    def talk_fixture(attrs \\ %{}) do
      {:ok, talk} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_talk()

      talk
    end

    test "paginate_talks/1 returns paginated list of talks" do
      for _ <- 1..20 do
        talk_fixture()
      end

      {:ok, %{talks: talks} = page} = Schedule.paginate_talks(%{})

      assert length(talks) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_talks/0 returns all talks" do
      talk = talk_fixture()
      assert Schedule.list_talks() == [talk]
    end

    test "get_talk!/1 returns the talk with given id" do
      talk = talk_fixture()
      assert Schedule.get_talk!(talk.id) == talk
    end

    test "create_talk/1 with valid data creates a talk" do
      assert {:ok, %Talk{} = talk} = Schedule.create_talk(@valid_attrs)
      assert talk.description == "some description"
      assert talk.room == "some room"
      assert talk.time_from == ~N[2010-04-17 14:00:00]
      assert talk.time_to == ~N[2010-04-17 14:00:00]
      assert talk.title == "some title"
    end

    test "create_talk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_talk(@invalid_attrs)
    end

    test "update_talk/2 with valid data updates the talk" do
      talk = talk_fixture()
      assert {:ok, talk} = Schedule.update_talk(talk, @update_attrs)
      assert %Talk{} = talk
      assert talk.description == "some updated description"
      assert talk.room == "some updated room"
      assert talk.time_from == ~N[2011-05-18 15:01:01]
      assert talk.time_to == ~N[2011-05-18 15:01:01]
      assert talk.title == "some updated title"
    end

    test "update_talk/2 with invalid data returns error changeset" do
      talk = talk_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_talk(talk, @invalid_attrs)
      assert talk == Schedule.get_talk!(talk.id)
    end

    test "delete_talk/1 deletes the talk" do
      talk = talk_fixture()
      assert {:ok, %Talk{}} = Schedule.delete_talk(talk)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_talk!(talk.id) end
    end

    test "change_talk/1 returns a talk changeset" do
      talk = talk_fixture()
      assert %Ecto.Changeset{} = Schedule.change_talk(talk)
    end
  end

  describe "streams" do
    alias Barcamp.Schedule.Stream

    @valid_attrs %{link: "some link", room: "some room"}
    @update_attrs %{link: "some updated link", room: "some updated room"}
    @invalid_attrs %{link: nil, room: nil}

    def stream_fixture(attrs \\ %{}) do
      {:ok, stream} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Schedule.create_stream()

      stream
    end

    test "paginate_streams/1 returns paginated list of streams" do
      for _ <- 1..20 do
        stream_fixture()
      end

      {:ok, %{streams: streams} = page} = Schedule.paginate_streams(%{})

      assert length(streams) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_streams/0 returns all streams" do
      stream = stream_fixture()
      assert Schedule.list_streams() == [stream]
    end

    test "get_stream!/1 returns the stream with given id" do
      stream = stream_fixture()
      assert Schedule.get_stream!(stream.id) == stream
    end

    test "create_stream/1 with valid data creates a stream" do
      assert {:ok, %Stream{} = stream} = Schedule.create_stream(@valid_attrs)
      assert stream.link == "some link"
      assert stream.room == "some room"
    end

    test "create_stream/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Schedule.create_stream(@invalid_attrs)
    end

    test "update_stream/2 with valid data updates the stream" do
      stream = stream_fixture()
      assert {:ok, stream} = Schedule.update_stream(stream, @update_attrs)
      assert %Stream{} = stream
      assert stream.link == "some updated link"
      assert stream.room == "some updated room"
    end

    test "update_stream/2 with invalid data returns error changeset" do
      stream = stream_fixture()
      assert {:error, %Ecto.Changeset{}} = Schedule.update_stream(stream, @invalid_attrs)
      assert stream == Schedule.get_stream!(stream.id)
    end

    test "delete_stream/1 deletes the stream" do
      stream = stream_fixture()
      assert {:ok, %Stream{}} = Schedule.delete_stream(stream)
      assert_raise Ecto.NoResultsError, fn -> Schedule.get_stream!(stream.id) end
    end

    test "change_stream/1 returns a stream changeset" do
      stream = stream_fixture()
      assert %Ecto.Changeset{} = Schedule.change_stream(stream)
    end
  end
end
