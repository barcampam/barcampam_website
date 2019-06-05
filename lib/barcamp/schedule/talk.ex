defmodule Barcamp.Schedule.Talk do
  use Ecto.Schema
  import Ecto.Changeset

  schema "talks" do
    field :description, :string
    field :room, :string
    field :day, :integer
    field :time_from, :time
    field :time_to, :time
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(talk, attrs) do
    talk
    |> cast(attrs, [:title, :description, :room, :day, :time_from, :time_to])
    |> validate_required([:title, :description, :room, :day, :time_from, :time_to])
  end
end
