defmodule Barcamp.Repo.Migrations.CreateFaqs do
  use Ecto.Migration

  def change do
    create table(:faqs) do
      add :question_eng, :text
      add :question_arm, :text
      add :answer_eng, :text
      add :answer_arm, :text

      timestamps()
    end

  end
end
