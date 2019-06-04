defmodule Barcamp.Repo.Migrations.CreateTalks do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :title, :string
      add :description, :text
      add :room, :string
      add :day, :integer
      add :time_from, :naive_datetime
      add :time_to, :naive_datetime

      timestamps()
    end
  end
end
