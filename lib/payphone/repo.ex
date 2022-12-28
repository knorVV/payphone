defmodule Payphone.Repo do
  use Ecto.Repo,
    otp_app: :payphone,
    adapter: Ecto.Adapters.Postgres
end
