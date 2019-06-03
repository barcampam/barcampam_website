# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :barcamp,
  ecto_repos: [Barcamp.Repo]

# Configures the endpoint
config :barcamp, BarcampWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "jq9S9OOjjdQg53QMVmYvtOlzfeoyaX5NoIBywIr6/J72cqBwDCH+KA3ia8rzkeOj",
  render_errors: [view: BarcampWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Barcamp.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Internationalization
config :barcamp, BarcampWeb.Gettext, default_locale: "en", locales: ["en", "am"]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
