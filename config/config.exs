# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :payphone,
  ecto_repos: [Payphone.Repo]

# Configures the endpoint
config :payphone, PayphoneWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uuMqvWu5oMLHpt9UHBZ+0quIsD3rNCbIsI9JknoR9njR751Wrd0myNShs81doD0V",
  render_errors: [view: PayphoneWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: Payphone.PubSub,
  live_view: [signing_salt: "X2S39pDT"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :payphone, Payphone.UseCases.Payments, endpoint: "https://pay.payphonetodoesposible.com"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
