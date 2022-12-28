defmodule Payphone.Payments.Payment do
  use Ecto.Schema
  import Ecto.Changeset

  @required_fields [:payment_id, :amount]

  schema "payments" do
    field :payment_id, :integer
    field :status, :integer
    field :amount, :integer
    field :tax, :integer

    timestamps()
  end

  @doc false
  def changeset(payment, attrs) do
    payment
    |> cast(attrs, @required_fields ++ [:status, :tax])
    |> validate_required(@required_fields)
  end
end
