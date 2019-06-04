defmodule Barcamp.Repo.Migrations.CreateSpeakers do
  use Ecto.Migration

  def change do
    create table(:speakers) do
      add :name, :string
      add :bio, :text
      add :topics, :string
      add :facebook, :string
      add :twitter, :string
      add :website, :string
      add :instagram, :string
      add :photo, :binary
      add :is_special, :boolean, default: false, null: false
      add :linkedin, :string

      timestamps()
    end

  end
end
