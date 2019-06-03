defmodule Barcamp.SpeakersTest do
  use Barcamp.DataCase

  alias Barcamp.Speakers

  describe "speakers" do
    alias Barcamp.Speakers.Speaker

    @valid_attrs %{bio_en: "some bio_en", bio_hy: "some bio_hy", facebook: "some facebook", instagram: "some instagram", is_special: true, linkedin: "some linkedin", name_en: "some name_en", name_hy: "some name_hy", photo: "some photo", topics_en: "some topics_en", topics_hy: "some topics_hy", twitter: "some twitter", website: "some website"}
    @update_attrs %{bio_en: "some updated bio_en", bio_hy: "some updated bio_hy", facebook: "some updated facebook", instagram: "some updated instagram", is_special: false, linkedin: "some updated linkedin", name_en: "some updated name_en", name_hy: "some updated name_hy", photo: "some updated photo", topics_en: "some updated topics_en", topics_hy: "some updated topics_hy", twitter: "some updated twitter", website: "some updated website"}
    @invalid_attrs %{bio_en: nil, bio_hy: nil, facebook: nil, instagram: nil, is_special: nil, linkedin: nil, name_en: nil, name_hy: nil, photo: nil, topics_en: nil, topics_hy: nil, twitter: nil, website: nil}

    def speaker_fixture(attrs \\ %{}) do
      {:ok, speaker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Speakers.create_speaker()

      speaker
    end

    test "list_speakers/0 returns all speakers" do
      speaker = speaker_fixture()
      assert Speakers.list_speakers() == [speaker]
    end

    test "get_speaker!/1 returns the speaker with given id" do
      speaker = speaker_fixture()
      assert Speakers.get_speaker!(speaker.id) == speaker
    end

    test "create_speaker/1 with valid data creates a speaker" do
      assert {:ok, %Speaker{} = speaker} = Speakers.create_speaker(@valid_attrs)
      assert speaker.bio_en == "some bio_en"
      assert speaker.bio_hy == "some bio_hy"
      assert speaker.facebook == "some facebook"
      assert speaker.instagram == "some instagram"
      assert speaker.is_special == true
      assert speaker.linkedin == "some linkedin"
      assert speaker.name_en == "some name_en"
      assert speaker.name_hy == "some name_hy"
      assert speaker.photo == "some photo"
      assert speaker.topics_en == "some topics_en"
      assert speaker.topics_hy == "some topics_hy"
      assert speaker.twitter == "some twitter"
      assert speaker.website == "some website"
    end

    test "create_speaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Speakers.create_speaker(@invalid_attrs)
    end

    test "update_speaker/2 with valid data updates the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{} = speaker} = Speakers.update_speaker(speaker, @update_attrs)
      assert speaker.bio_en == "some updated bio_en"
      assert speaker.bio_hy == "some updated bio_hy"
      assert speaker.facebook == "some updated facebook"
      assert speaker.instagram == "some updated instagram"
      assert speaker.is_special == false
      assert speaker.linkedin == "some updated linkedin"
      assert speaker.name_en == "some updated name_en"
      assert speaker.name_hy == "some updated name_hy"
      assert speaker.photo == "some updated photo"
      assert speaker.topics_en == "some updated topics_en"
      assert speaker.topics_hy == "some updated topics_hy"
      assert speaker.twitter == "some updated twitter"
      assert speaker.website == "some updated website"
    end

    test "update_speaker/2 with invalid data returns error changeset" do
      speaker = speaker_fixture()
      assert {:error, %Ecto.Changeset{}} = Speakers.update_speaker(speaker, @invalid_attrs)
      assert speaker == Speakers.get_speaker!(speaker.id)
    end

    test "delete_speaker/1 deletes the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{}} = Speakers.delete_speaker(speaker)
      assert_raise Ecto.NoResultsError, fn -> Speakers.get_speaker!(speaker.id) end
    end

    test "change_speaker/1 returns a speaker changeset" do
      speaker = speaker_fixture()
      assert %Ecto.Changeset{} = Speakers.change_speaker(speaker)
    end
  end

  describe "talks" do
    alias Barcamp.Speakers.Talk

    @valid_attrs %{description: "some description", room: "some room", speaker: "some speaker", time_from: ~N[2010-04-17 14:00:00], time_to: ~N[2010-04-17 14:00:00], topics: "some topics"}
    @update_attrs %{description: "some updated description", room: "some updated room", speaker: "some updated speaker", time_from: ~N[2011-05-18 15:01:01], time_to: ~N[2011-05-18 15:01:01], topics: "some updated topics"}
    @invalid_attrs %{description: nil, room: nil, speaker: nil, time_from: nil, time_to: nil, topics: nil}

    def talk_fixture(attrs \\ %{}) do
      {:ok, talk} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Speakers.create_talk()

      talk
    end

    test "list_talks/0 returns all talks" do
      talk = talk_fixture()
      assert Speakers.list_talks() == [talk]
    end

    test "get_talk!/1 returns the talk with given id" do
      talk = talk_fixture()
      assert Speakers.get_talk!(talk.id) == talk
    end

    test "create_talk/1 with valid data creates a talk" do
      assert {:ok, %Talk{} = talk} = Speakers.create_talk(@valid_attrs)
      assert talk.description == "some description"
      assert talk.room == "some room"
      assert talk.speaker == "some speaker"
      assert talk.time_from == ~N[2010-04-17 14:00:00]
      assert talk.time_to == ~N[2010-04-17 14:00:00]
      assert talk.topics == "some topics"
    end

    test "create_talk/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Speakers.create_talk(@invalid_attrs)
    end

    test "update_talk/2 with valid data updates the talk" do
      talk = talk_fixture()
      assert {:ok, %Talk{} = talk} = Speakers.update_talk(talk, @update_attrs)
      assert talk.description == "some updated description"
      assert talk.room == "some updated room"
      assert talk.speaker == "some updated speaker"
      assert talk.time_from == ~N[2011-05-18 15:01:01]
      assert talk.time_to == ~N[2011-05-18 15:01:01]
      assert talk.topics == "some updated topics"
    end

    test "update_talk/2 with invalid data returns error changeset" do
      talk = talk_fixture()
      assert {:error, %Ecto.Changeset{}} = Speakers.update_talk(talk, @invalid_attrs)
      assert talk == Speakers.get_talk!(talk.id)
    end

    test "delete_talk/1 deletes the talk" do
      talk = talk_fixture()
      assert {:ok, %Talk{}} = Speakers.delete_talk(talk)
      assert_raise Ecto.NoResultsError, fn -> Speakers.get_talk!(talk.id) end
    end

    test "change_talk/1 returns a talk changeset" do
      talk = talk_fixture()
      assert %Ecto.Changeset{} = Speakers.change_talk(talk)
    end
  end
end
