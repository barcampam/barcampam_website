defmodule Barcamp.LogosTest do
  use Barcamp.DataCase

  alias Barcamp.Logos

  describe "sponsors" do
    alias Barcamp.Logos.Sponsor

    @valid_attrs %{logo: "some logo"}
    @update_attrs %{logo: "some updated logo"}
    @invalid_attrs %{logo: nil}

    def sponsor_fixture(attrs \\ %{}) do
      {:ok, sponsor} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logos.create_sponsor()

      sponsor
    end

    test "paginate_sponsors/1 returns paginated list of sponsors" do
      for _ <- 1..20 do
        sponsor_fixture()
      end

      {:ok, %{sponsors: sponsors} = page} = Logos.paginate_sponsors(%{})

      assert length(sponsors) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_sponsors/0 returns all sponsors" do
      sponsor = sponsor_fixture()
      assert Logos.list_sponsors() == [sponsor]
    end

    test "get_sponsor!/1 returns the sponsor with given id" do
      sponsor = sponsor_fixture()
      assert Logos.get_sponsor!(sponsor.id) == sponsor
    end

    test "create_sponsor/1 with valid data creates a sponsor" do
      assert {:ok, %Sponsor{} = sponsor} = Logos.create_sponsor(@valid_attrs)
      assert sponsor.logo == "some logo"
    end

    test "create_sponsor/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logos.create_sponsor(@invalid_attrs)
    end

    test "update_sponsor/2 with valid data updates the sponsor" do
      sponsor = sponsor_fixture()
      assert {:ok, sponsor} = Logos.update_sponsor(sponsor, @update_attrs)
      assert %Sponsor{} = sponsor
      assert sponsor.logo == "some updated logo"
    end

    test "update_sponsor/2 with invalid data returns error changeset" do
      sponsor = sponsor_fixture()
      assert {:error, %Ecto.Changeset{}} = Logos.update_sponsor(sponsor, @invalid_attrs)
      assert sponsor == Logos.get_sponsor!(sponsor.id)
    end

    test "delete_sponsor/1 deletes the sponsor" do
      sponsor = sponsor_fixture()
      assert {:ok, %Sponsor{}} = Logos.delete_sponsor(sponsor)
      assert_raise Ecto.NoResultsError, fn -> Logos.get_sponsor!(sponsor.id) end
    end

    test "change_sponsor/1 returns a sponsor changeset" do
      sponsor = sponsor_fixture()
      assert %Ecto.Changeset{} = Logos.change_sponsor(sponsor)
    end
  end

  describe "generals" do
    alias Barcamp.Logos.General

    @valid_attrs %{logo: "some logo"}
    @update_attrs %{logo: "some updated logo"}
    @invalid_attrs %{logo: nil}

    def general_fixture(attrs \\ %{}) do
      {:ok, general} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logos.create_general()

      general
    end

    test "paginate_generals/1 returns paginated list of generals" do
      for _ <- 1..20 do
        general_fixture()
      end

      {:ok, %{generals: generals} = page} = Logos.paginate_generals(%{})

      assert length(generals) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_generals/0 returns all generals" do
      general = general_fixture()
      assert Logos.list_generals() == [general]
    end

    test "get_general!/1 returns the general with given id" do
      general = general_fixture()
      assert Logos.get_general!(general.id) == general
    end

    test "create_general/1 with valid data creates a general" do
      assert {:ok, %General{} = general} = Logos.create_general(@valid_attrs)
      assert general.logo == "some logo"
    end

    test "create_general/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logos.create_general(@invalid_attrs)
    end

    test "update_general/2 with valid data updates the general" do
      general = general_fixture()
      assert {:ok, general} = Logos.update_general(general, @update_attrs)
      assert %General{} = general
      assert general.logo == "some updated logo"
    end

    test "update_general/2 with invalid data returns error changeset" do
      general = general_fixture()
      assert {:error, %Ecto.Changeset{}} = Logos.update_general(general, @invalid_attrs)
      assert general == Logos.get_general!(general.id)
    end

    test "delete_general/1 deletes the general" do
      general = general_fixture()
      assert {:ok, %General{}} = Logos.delete_general(general)
      assert_raise Ecto.NoResultsError, fn -> Logos.get_general!(general.id) end
    end

    test "change_general/1 returns a general changeset" do
      general = general_fixture()
      assert %Ecto.Changeset{} = Logos.change_general(general)
    end
  end

  describe "partners" do
    alias Barcamp.Logos.Partner

    @valid_attrs %{logo: "some logo"}
    @update_attrs %{logo: "some updated logo"}
    @invalid_attrs %{logo: nil}

    def partner_fixture(attrs \\ %{}) do
      {:ok, partner} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Logos.create_partner()

      partner
    end

    test "paginate_partners/1 returns paginated list of partners" do
      for _ <- 1..20 do
        partner_fixture()
      end

      {:ok, %{partners: partners} = page} = Logos.paginate_partners(%{})

      assert length(partners) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_partners/0 returns all partners" do
      partner = partner_fixture()
      assert Logos.list_partners() == [partner]
    end

    test "get_partner!/1 returns the partner with given id" do
      partner = partner_fixture()
      assert Logos.get_partner!(partner.id) == partner
    end

    test "create_partner/1 with valid data creates a partner" do
      assert {:ok, %Partner{} = partner} = Logos.create_partner(@valid_attrs)
      assert partner.logo == "some logo"
    end

    test "create_partner/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Logos.create_partner(@invalid_attrs)
    end

    test "update_partner/2 with valid data updates the partner" do
      partner = partner_fixture()
      assert {:ok, partner} = Logos.update_partner(partner, @update_attrs)
      assert %Partner{} = partner
      assert partner.logo == "some updated logo"
    end

    test "update_partner/2 with invalid data returns error changeset" do
      partner = partner_fixture()
      assert {:error, %Ecto.Changeset{}} = Logos.update_partner(partner, @invalid_attrs)
      assert partner == Logos.get_partner!(partner.id)
    end

    test "delete_partner/1 deletes the partner" do
      partner = partner_fixture()
      assert {:ok, %Partner{}} = Logos.delete_partner(partner)
      assert_raise Ecto.NoResultsError, fn -> Logos.get_partner!(partner.id) end
    end

    test "change_partner/1 returns a partner changeset" do
      partner = partner_fixture()
      assert %Ecto.Changeset{} = Logos.change_partner(partner)
    end
  end
end
