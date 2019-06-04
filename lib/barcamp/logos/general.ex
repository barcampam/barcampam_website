defmodule Barcamp.Logos.General do
  use Ecto.Schema
  import Ecto.Changeset

  schema "generals" do
    field :logo, :binary

    timestamps()
  end

  @doc false
  def changeset(general, attrs) do
    general
    |> cast(attrs, [:logo])
    |> validate_required([:logo])
  end
end
