defmodule PayphoneWeb.PaymentController do
  use PayphoneWeb, :controller

  alias Payphone.UseCases.Payments

  action_fallback PayphoneWeb.FallbackController

  def create(conn, payment_params) do
    {:ok, payment} = Payments.send_payment_info(payment_params)

    render(conn, "payment.json", %{payment: payment})
  end

  def handle_response(conn, params) do
    {:ok, transaction_result} = Payments.get_transaction_result(params)

    render(conn, "payment.json", %{transaction_result: transaction_result})
  end

end
