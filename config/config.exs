# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :lang_equiv,
  ecto_repos: [LangEquiv.Repo]

# Configures the endpoint
config :lang_equiv, LangEquivWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "rwXaIiC8fxq0MVTl4RoRZNDXkL9r9F7PH9XHItIy+RLxvfrpN6yF4IIRAWaRxU/q",
  render_errors: [view: LangEquivWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: LangEquiv.PubSub,
  live_view: [signing_salt: "K0jvcAcF"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
