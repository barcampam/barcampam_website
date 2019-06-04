defmodule Barcamp.Logos.Partner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "partners" do
    field :logo, :binary

    timestamps()
  end

  @doc false
  def changeset(partner, attrs) do
    partner
    |> cast(attrs, [:logo])
    |> validate_required([:logo])
  end
end
