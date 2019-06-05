defmodule Barcamp do
  @moduledoc """
  Barcamp keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  require Logger

  def migrate do
    case Application.ensure_all_started(:barcamp) do
      {:ok, _} ->
        path = Application.app_dir(:barcamp, "priv/repo/migrations")
        Ecto.Migrator.run(Barcamp.Repo, path, :up, all: true)
        Logger.info("Success!")

      {:error, data} ->
        Logger.info("Migration unsuccessful, got: #{inspect(data)}")
    end
  end

  def seed do
    case :barcamp |> Application.app_dir("priv/repo/seeds.exs") |> Code.eval_file() do
      {{:ok, _}, _} ->
        Logger.info("Success!")

      {{:error, changeset}, _} ->
        Logger.info("Seed unsuccessful, got: #{inspect(changeset)}")
    end
  end
end
