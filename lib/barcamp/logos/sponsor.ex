defmodule Barcamp.Logos.Sponsor do
  use Ecto.Schema
  import Ecto.Changeset

  schema "sponsors" do
    field :logo, :binary

    timestamps()
  end

  @doc false
  def changeset(sponsor, attrs) do
    sponsor
    |> cast(attrs, [:logo])
    |> validate_required([:logo])
  end
end
