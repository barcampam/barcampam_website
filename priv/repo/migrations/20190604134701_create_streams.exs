defmodule Barcamp.Repo.Migrations.CreateStreams do
  use Ecto.Migration

  def change do
    create table(:streams) do
      add :link, :string
      add :room, :string

      timestamps()
    end

  end
end
