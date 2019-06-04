defmodule Barcamp.Repo.Migrations.CreateAbouts do
  use Ecto.Migration

  def change do
    create table(:abouts) do
      add :text_eng, :text
      add :text_arm, :text

      timestamps()
    end

  end
end
