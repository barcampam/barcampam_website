defmodule Barcamp.Repo do
  use Ecto.Repo,
    otp_app: :barcamp,
    adapter: Ecto.Adapters.Postgres
end
