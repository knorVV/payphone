defmodule PayphoneWeb.PaymentView do
  use PayphoneWeb, :view
  alias PayphoneWeb.PaymentView

  def render("index.json", %{payments: payments}) do
    %{data: render_many(payments, PaymentView, "payment.json")}
  end

  def render("show.json", %{payment: payment}) do
    payment
  end

  def render("payment.json", %{payment: payment}) do
    %{id: payment.id}
  end
end
