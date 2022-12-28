defmodule Payphone.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do

      timestamps()
    end

  end
end
