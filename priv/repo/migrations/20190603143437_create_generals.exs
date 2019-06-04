defmodule Barcamp.Repo.Migrations.CreateGenerals do
  use Ecto.Migration

  def change do
    create table(:generals) do
      add :logo, :bytea

      timestamps()
    end
  end
end
