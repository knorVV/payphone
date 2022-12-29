defmodule PayphoneWeb.PaymentView do
  use PayphoneWeb, :view

  def render("payment.json", %{payment: payment}) do
    %{payment: payment}
  end

  def render("payment.json", %{transaction_result: transaction_result}) do
    %{transaction_result: transaction_result}
  end
end
