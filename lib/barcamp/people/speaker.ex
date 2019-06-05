defmodule Barcamp.People.Speaker do
  use Ecto.Schema
  import Ecto.Changeset

  schema "speakers" do
    field :bio, :string
    field :facebook, :string
    field :instagram, :string
    field :is_special, :boolean, default: false
    field :linkedin, :string
    field :name, :string
    field :photo, :binary
    field :topics, :string
    field :twitter, :string
    field :website, :string

    timestamps()
  end

  @doc false
  def changeset(speaker, attrs) do
    speaker
    |> cast(attrs, [
      :name,
      :bio,
      :topics,
      :facebook,
      :twitter,
      :website,
      :instagram,
      :photo,
      :is_special,
      :linkedin
    ])
    |> validate_required([:name, :photo, :is_special])
  end
end
