# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :classroom,
  namespace: Classroom

# Configures the endpoint
config :classroom, ClassroomWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kAUg6GfxGnQ+80Hrv6+7CfuBbBcDYkZqlkzz1o4bCKI0DoIzdyC9yl9BKeDXvCea",
  render_errors: [view: ClassroomWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Classroom.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
