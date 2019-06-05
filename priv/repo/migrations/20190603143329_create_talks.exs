defmodule Barcamp.Repo.Migrations.CreateTalks do
  use Ecto.Migration

  def change do
    create table(:talks) do
      add :title, :string
      add :description, :text
      add :room, :string
      add :day, :integer
      add :time_from, :time
      add :time_to, :time

      timestamps()
    end
  end
end
