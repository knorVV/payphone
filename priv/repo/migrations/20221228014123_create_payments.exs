defmodule Payphone.Repo.Migrations.CreatePayments do
  use Ecto.Migration

  def change do
    create table(:payments) do
      add :payment_id, :integer
      add :status, :integer
      add :amount, :integer
      add :tax, :integer

      timestamps()
    end

  end
end
