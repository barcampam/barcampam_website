defmodule Barcamp.PeopleTest do
  use Barcamp.DataCase

  alias Barcamp.People

  describe "speakers" do
    alias Barcamp.People.Speaker

    @valid_attrs %{bio: "some bio", facebook: "some facebook", instagram: "some instagram", is_special: true, linkedin: "some linkedin", name: "some name", photo: "some photo", topics: "some topics", twitter: "some twitter", website: "some website"}
    @update_attrs %{bio: "some updated bio", facebook: "some updated facebook", instagram: "some updated instagram", is_special: false, linkedin: "some updated linkedin", name: "some updated name", photo: "some updated photo", topics: "some updated topics", twitter: "some updated twitter", website: "some updated website"}
    @invalid_attrs %{bio: nil, facebook: nil, instagram: nil, is_special: nil, linkedin: nil, name: nil, photo: nil, topics: nil, twitter: nil, website: nil}

    def speaker_fixture(attrs \\ %{}) do
      {:ok, speaker} =
        attrs
        |> Enum.into(@valid_attrs)
        |> People.create_speaker()

      speaker
    end

    test "paginate_speakers/1 returns paginated list of speakers" do
      for _ <- 1..20 do
        speaker_fixture()
      end

      {:ok, %{speakers: speakers} = page} = People.paginate_speakers(%{})

      assert length(speakers) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_speakers/0 returns all speakers" do
      speaker = speaker_fixture()
      assert People.list_speakers() == [speaker]
    end

    test "get_speaker!/1 returns the speaker with given id" do
      speaker = speaker_fixture()
      assert People.get_speaker!(speaker.id) == speaker
    end

    test "create_speaker/1 with valid data creates a speaker" do
      assert {:ok, %Speaker{} = speaker} = People.create_speaker(@valid_attrs)
      assert speaker.bio == "some bio"
      assert speaker.facebook == "some facebook"
      assert speaker.instagram == "some instagram"
      assert speaker.is_special == true
      assert speaker.linkedin == "some linkedin"
      assert speaker.name == "some name"
      assert speaker.photo == "some photo"
      assert speaker.topics == "some topics"
      assert speaker.twitter == "some twitter"
      assert speaker.website == "some website"
    end

    test "create_speaker/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = People.create_speaker(@invalid_attrs)
    end

    test "update_speaker/2 with valid data updates the speaker" do
      speaker = speaker_fixture()
      assert {:ok, speaker} = People.update_speaker(speaker, @update_attrs)
      assert %Speaker{} = speaker
      assert speaker.bio == "some updated bio"
      assert speaker.facebook == "some updated facebook"
      assert speaker.instagram == "some updated instagram"
      assert speaker.is_special == false
      assert speaker.linkedin == "some updated linkedin"
      assert speaker.name == "some updated name"
      assert speaker.photo == "some updated photo"
      assert speaker.topics == "some updated topics"
      assert speaker.twitter == "some updated twitter"
      assert speaker.website == "some updated website"
    end

    test "update_speaker/2 with invalid data returns error changeset" do
      speaker = speaker_fixture()
      assert {:error, %Ecto.Changeset{}} = People.update_speaker(speaker, @invalid_attrs)
      assert speaker == People.get_speaker!(speaker.id)
    end

    test "delete_speaker/1 deletes the speaker" do
      speaker = speaker_fixture()
      assert {:ok, %Speaker{}} = People.delete_speaker(speaker)
      assert_raise Ecto.NoResultsError, fn -> People.get_speaker!(speaker.id) end
    end

    test "change_speaker/1 returns a speaker changeset" do
      speaker = speaker_fixture()
      assert %Ecto.Changeset{} = People.change_speaker(speaker)
    end
  end
end
