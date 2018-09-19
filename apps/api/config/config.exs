# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :api,
  namespace: Api,
  ecto_repos: [Api.Repo]

config :api, Api.Guardian,
  issuer: "gradient.education",
  # TODO: Remove to env
  secret_key: "uxAmXIjI78q3KOfX4eCdt95dyY5U6tdg/vxRE8qA7jFUBJWB5z9EgoOge2/VE9qx",
  serializer: Api.Guardian

# Configures the endpoint
config :api, ApiWeb.Endpoint,
  url: [host: "localhost"],
  pubsub: [name: Api.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
