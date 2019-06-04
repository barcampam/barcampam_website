defmodule Barcamp.Repo.Migrations.CreateSponsors do
  use Ecto.Migration

  def change do
    create table(:sponsors) do
      add :logo, :bytea

      timestamps()
    end
  end
end
