# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :consumindoapis,
  ecto_repos: [Consumindoapis.Repo]

# Configures Guardian for JWT generation

config :consumindoapis, ConsumindoapisWeb.Auth.Guardian,
  issuer: "Consumindo APIs",
  secret_key: "l6zmTLeS0Kb3Y3sog3m9Bn5oPCFWIS5xyk5CIjnu1qh4qGOzrNCbtI5DzjIYIejS"

config :consumindoapis, ConsumindoapisWeb.Auth.Pipeline,
  module: ConsumindoapisWeb.Auth.Guardian,
  error_handler: ConsumindoapisWeb.Auth.ErrorHandler

# Configures the endpoint
config :consumindoapis, ConsumindoapisWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "LVade7quK+PDtmVtuLvsG5QKKitDXOAy27+WD4ps55VXYAlOQSzlIZRzlejwU5LG",
  render_errors: [view: ConsumindoapisWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Consumindoapis.PubSub,
  live_view: [signing_salt: "t4EZy46y"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :consumindoapis, Consumindoapis.Repositories.Get,
  github_repos_adapter: Consumindoapis.Github.Client

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
