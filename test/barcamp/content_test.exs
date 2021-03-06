defmodule Barcamp.ContentTest do
  use Barcamp.DataCase

  alias Barcamp.Content

  describe "faqs" do
    alias Barcamp.Content.Faq

    @valid_attrs %{answer_en: "some answer_en", answer_hy: "some answer_hy", question_en: "some question_en", question_hy: "some question_hy"}
    @update_attrs %{answer_en: "some updated answer_en", answer_hy: "some updated answer_hy", question_en: "some updated question_en", question_hy: "some updated question_hy"}
    @invalid_attrs %{answer_en: nil, answer_hy: nil, question_en: nil, question_hy: nil}

    def faq_fixture(attrs \\ %{}) do
      {:ok, faq} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_faq()

      faq
    end

    test "list_faqs/0 returns all faqs" do
      faq = faq_fixture()
      assert Content.list_faqs() == [faq]
    end

    test "get_faq!/1 returns the faq with given id" do
      faq = faq_fixture()
      assert Content.get_faq!(faq.id) == faq
    end

    test "create_faq/1 with valid data creates a faq" do
      assert {:ok, %Faq{} = faq} = Content.create_faq(@valid_attrs)
      assert faq.answer_en == "some answer_en"
      assert faq.answer_hy == "some answer_hy"
      assert faq.question_en == "some question_en"
      assert faq.question_hy == "some question_hy"
    end

    test "create_faq/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_faq(@invalid_attrs)
    end

    test "update_faq/2 with valid data updates the faq" do
      faq = faq_fixture()
      assert {:ok, %Faq{} = faq} = Content.update_faq(faq, @update_attrs)
      assert faq.answer_en == "some updated answer_en"
      assert faq.answer_hy == "some updated answer_hy"
      assert faq.question_en == "some updated question_en"
      assert faq.question_hy == "some updated question_hy"
    end

    test "update_faq/2 with invalid data returns error changeset" do
      faq = faq_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_faq(faq, @invalid_attrs)
      assert faq == Content.get_faq!(faq.id)
    end

    test "delete_faq/1 deletes the faq" do
      faq = faq_fixture()
      assert {:ok, %Faq{}} = Content.delete_faq(faq)
      assert_raise Ecto.NoResultsError, fn -> Content.get_faq!(faq.id) end
    end

    test "change_faq/1 returns a faq changeset" do
      faq = faq_fixture()
      assert %Ecto.Changeset{} = Content.change_faq(faq)
    end
  end

  describe "texts" do
    alias Barcamp.Content.Text

    @valid_attrs %{key: "some key", value_en: "some value_en", value_hy: "some value_hy"}
    @update_attrs %{key: "some updated key", value_en: "some updated value_en", value_hy: "some updated value_hy"}
    @invalid_attrs %{key: nil, value_en: nil, value_hy: nil}

    def text_fixture(attrs \\ %{}) do
      {:ok, text} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_text()

      text
    end

    test "list_texts/0 returns all texts" do
      text = text_fixture()
      assert Content.list_texts() == [text]
    end

    test "get_text!/1 returns the text with given id" do
      text = text_fixture()
      assert Content.get_text!(text.id) == text
    end

    test "create_text/1 with valid data creates a text" do
      assert {:ok, %Text{} = text} = Content.create_text(@valid_attrs)
      assert text.key == "some key"
      assert text.value_en == "some value_en"
      assert text.value_hy == "some value_hy"
    end

    test "create_text/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_text(@invalid_attrs)
    end

    test "update_text/2 with valid data updates the text" do
      text = text_fixture()
      assert {:ok, %Text{} = text} = Content.update_text(text, @update_attrs)
      assert text.key == "some updated key"
      assert text.value_en == "some updated value_en"
      assert text.value_hy == "some updated value_hy"
    end

    test "update_text/2 with invalid data returns error changeset" do
      text = text_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_text(text, @invalid_attrs)
      assert text == Content.get_text!(text.id)
    end

    test "delete_text/1 deletes the text" do
      text = text_fixture()
      assert {:ok, %Text{}} = Content.delete_text(text)
      assert_raise Ecto.NoResultsError, fn -> Content.get_text!(text.id) end
    end

    test "change_text/1 returns a text changeset" do
      text = text_fixture()
      assert %Ecto.Changeset{} = Content.change_text(text)
    end
  end

  describe "affiliates" do
    alias Barcamp.Content.Affiliate

    @valid_attrs %{logo: "some logo", type: "some type"}
    @update_attrs %{logo: "some updated logo", type: "some updated type"}
    @invalid_attrs %{logo: nil, type: nil}

    def affiliate_fixture(attrs \\ %{}) do
      {:ok, affiliate} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_affiliate()

      affiliate
    end

    test "list_affiliates/0 returns all affiliates" do
      affiliate = affiliate_fixture()
      assert Content.list_affiliates() == [affiliate]
    end

    test "get_affiliate!/1 returns the affiliate with given id" do
      affiliate = affiliate_fixture()
      assert Content.get_affiliate!(affiliate.id) == affiliate
    end

    test "create_affiliate/1 with valid data creates a affiliate" do
      assert {:ok, %Affiliate{} = affiliate} = Content.create_affiliate(@valid_attrs)
      assert affiliate.logo == "some logo"
      assert affiliate.type == "some type"
    end

    test "create_affiliate/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_affiliate(@invalid_attrs)
    end

    test "update_affiliate/2 with valid data updates the affiliate" do
      affiliate = affiliate_fixture()
      assert {:ok, %Affiliate{} = affiliate} = Content.update_affiliate(affiliate, @update_attrs)
      assert affiliate.logo == "some updated logo"
      assert affiliate.type == "some updated type"
    end

    test "update_affiliate/2 with invalid data returns error changeset" do
      affiliate = affiliate_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_affiliate(affiliate, @invalid_attrs)
      assert affiliate == Content.get_affiliate!(affiliate.id)
    end

    test "delete_affiliate/1 deletes the affiliate" do
      affiliate = affiliate_fixture()
      assert {:ok, %Affiliate{}} = Content.delete_affiliate(affiliate)
      assert_raise Ecto.NoResultsError, fn -> Content.get_affiliate!(affiliate.id) end
    end

    test "change_affiliate/1 returns a affiliate changeset" do
      affiliate = affiliate_fixture()
      assert %Ecto.Changeset{} = Content.change_affiliate(affiliate)
    end
  end

  describe "faqs" do
    alias Barcamp.Content.Faq

    @valid_attrs %{answer_arm: "some answer_arm", answer_eng: "some answer_eng", question_arm: "some question_arm", question_eng: "some question_eng"}
    @update_attrs %{answer_arm: "some updated answer_arm", answer_eng: "some updated answer_eng", question_arm: "some updated question_arm", question_eng: "some updated question_eng"}
    @invalid_attrs %{answer_arm: nil, answer_eng: nil, question_arm: nil, question_eng: nil}

    def faq_fixture(attrs \\ %{}) do
      {:ok, faq} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_faq()

      faq
    end

    test "paginate_faqs/1 returns paginated list of faqs" do
      for _ <- 1..20 do
        faq_fixture()
      end

      {:ok, %{faqs: faqs} = page} = Content.paginate_faqs(%{})

      assert length(faqs) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_faqs/0 returns all faqs" do
      faq = faq_fixture()
      assert Content.list_faqs() == [faq]
    end

    test "get_faq!/1 returns the faq with given id" do
      faq = faq_fixture()
      assert Content.get_faq!(faq.id) == faq
    end

    test "create_faq/1 with valid data creates a faq" do
      assert {:ok, %Faq{} = faq} = Content.create_faq(@valid_attrs)
      assert faq.answer_arm == "some answer_arm"
      assert faq.answer_eng == "some answer_eng"
      assert faq.question_arm == "some question_arm"
      assert faq.question_eng == "some question_eng"
    end

    test "create_faq/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_faq(@invalid_attrs)
    end

    test "update_faq/2 with valid data updates the faq" do
      faq = faq_fixture()
      assert {:ok, faq} = Content.update_faq(faq, @update_attrs)
      assert %Faq{} = faq
      assert faq.answer_arm == "some updated answer_arm"
      assert faq.answer_eng == "some updated answer_eng"
      assert faq.question_arm == "some updated question_arm"
      assert faq.question_eng == "some updated question_eng"
    end

    test "update_faq/2 with invalid data returns error changeset" do
      faq = faq_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_faq(faq, @invalid_attrs)
      assert faq == Content.get_faq!(faq.id)
    end

    test "delete_faq/1 deletes the faq" do
      faq = faq_fixture()
      assert {:ok, %Faq{}} = Content.delete_faq(faq)
      assert_raise Ecto.NoResultsError, fn -> Content.get_faq!(faq.id) end
    end

    test "change_faq/1 returns a faq changeset" do
      faq = faq_fixture()
      assert %Ecto.Changeset{} = Content.change_faq(faq)
    end
  end

  describe "abouts" do
    alias Barcamp.Content.About

    @valid_attrs %{text_arm: "some text_arm", text_eng: "some text_eng"}
    @update_attrs %{text_arm: "some updated text_arm", text_eng: "some updated text_eng"}
    @invalid_attrs %{text_arm: nil, text_eng: nil}

    def about_fixture(attrs \\ %{}) do
      {:ok, about} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Content.create_about()

      about
    end

    test "paginate_abouts/1 returns paginated list of abouts" do
      for _ <- 1..20 do
        about_fixture()
      end

      {:ok, %{abouts: abouts} = page} = Content.paginate_abouts(%{})

      assert length(abouts) == 15
      assert page.page_number == 1
      assert page.page_size == 15
      assert page.total_pages == 2
      assert page.total_entries == 20
      assert page.distance == 5
      assert page.sort_field == "inserted_at"
      assert page.sort_direction == "desc"
    end

    test "list_abouts/0 returns all abouts" do
      about = about_fixture()
      assert Content.list_abouts() == [about]
    end

    test "get_about!/1 returns the about with given id" do
      about = about_fixture()
      assert Content.get_about!(about.id) == about
    end

    test "create_about/1 with valid data creates a about" do
      assert {:ok, %About{} = about} = Content.create_about(@valid_attrs)
      assert about.text_arm == "some text_arm"
      assert about.text_eng == "some text_eng"
    end

    test "create_about/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Content.create_about(@invalid_attrs)
    end

    test "update_about/2 with valid data updates the about" do
      about = about_fixture()
      assert {:ok, about} = Content.update_about(about, @update_attrs)
      assert %About{} = about
      assert about.text_arm == "some updated text_arm"
      assert about.text_eng == "some updated text_eng"
    end

    test "update_about/2 with invalid data returns error changeset" do
      about = about_fixture()
      assert {:error, %Ecto.Changeset{}} = Content.update_about(about, @invalid_attrs)
      assert about == Content.get_about!(about.id)
    end

    test "delete_about/1 deletes the about" do
      about = about_fixture()
      assert {:ok, %About{}} = Content.delete_about(about)
      assert_raise Ecto.NoResultsError, fn -> Content.get_about!(about.id) end
    end

    test "change_about/1 returns a about changeset" do
      about = about_fixture()
      assert %Ecto.Changeset{} = Content.change_about(about)
    end
  end
end
