defmodule Barcamp.Content.About do
  use Ecto.Schema
  import Ecto.Changeset

  schema "abouts" do
    field :text_arm, :string
    field :text_eng, :string

    timestamps()
  end

  @doc false
  def changeset(about, attrs) do
    about
    |> cast(attrs, [:text_eng, :text_arm])
    |> validate_required([:text_eng, :text_arm])
  end
end
