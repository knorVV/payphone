defmodule Payphone do
  @moduledoc """
  Payphone keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @app_key :payphone

  def fetch_config(external_key, internal_key) do
    Application.fetch_env!(@app_key, external_key)[internal_key]
  end
end
