defmodule Barcamp.Content.Faq do
  use Ecto.Schema
  import Ecto.Changeset

  schema "faqs" do
    field :answer_arm, :string
    field :answer_eng, :string
    field :question_arm, :string
    field :question_eng, :string

    timestamps()
  end

  @doc false
  def changeset(faq, attrs) do
    faq
    |> cast(attrs, [:question_eng, :question_arm, :answer_eng, :answer_arm])
    |> validate_required([:question_eng, :question_arm, :answer_eng, :answer_arm])
  end
end
