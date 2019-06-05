defmodule Barcamp.Schedule.Stream do
  use Ecto.Schema
  import Ecto.Changeset

  schema "streams" do
    field :link, :string
    field :room, :string

    timestamps()
  end

  @doc false
  def changeset(stream, attrs) do
    stream
    |> cast(attrs, [:link, :room])
    |> validate_required([:link, :room])
  end
end
