defmodule Payphone.UseCases.Payments do
  @moduledoc false

  alias HTTPoison.Response
  alias Payphone.Payments

  @button_path "/api/button/Prepare"
  @confirm_path "/api/button/V2/Confirm "

  def endpoint, do: Payphone.fetch_config(__MODULE__, :endpoint)

  def send_payment_info(payment_data) do
    uniq_id = time_based_hash()
    url = endpoint() <> @button_path
    prepared_body = prepare_body(payment_data, uniq_id)
    headers = make_headers()
    
    case do_post_request(url, prepared_body, headers) do
      {:ok, body} ->
        result = parse_body(body)
        save_result(result, payment_data)

        # Пример
        # {:ok, %{
        #   "paymentId" => "ROquezy4tkWbtrOR2tpLRw",
        #   "payWithPayPhone" => "https://pay.payphonetodoesposible.com/PayPhone/Index?paymentId=ROquezy4tkWbtrOR2tpLRw",
        #   "payWithCard" => "https://pay.payphonetodoesposible.com/Anonymous/Index?paymentId=ROquezy4tkWbtrOR2tpLRw"
        # }}
        result

      {:error, reason} ->
        handle_error(reason)
    end
  end

  def get_transaction_result(params) do
    body =
      %{
        "id" => params["id"],
        "clientTxId" => params["clientTransactionId"]
      }
    url = endpoint() <> @confirm_path
    headers = make_headers()

    case do_post_request(url, body, headers) do
      {:ok, response_body} ->
        result = parse_body(response_body)
        put_status(result, params["clientTransactionId"])

        result

      {:error, reason} ->
        handle_error(reason)
    end
  end

  defp prepare_body(payment_data, uniq_id) do
    tax = payment_data["tax"] || 0
    main_data =
      %{
        "responseUrl" => "http://localhost:4000/api/response_handler",
        "amount" => payment_data["amount"],
        "clientTransactionId" => uniq_id
      }

    if payment_data["tax"] do
      Map.merge(main_data, %{
        "amountWithTax" => payment_data["amount"] + tax,
        "tax" => payment_data["tax"]
      })
    else
      Map.merge(main_data, %{
        "amountWithoutTax" => payment_data["amount"]
      })
    end
  end

  defp make_headers do
    [
      {"authorization", "some_token"},
      {"content-type", "application/json"}
    ]
  end

  defp time_based_hash do
    DateTime.utc_now()
    |> DateTime.to_unix(:nanosecond)
    |> to_string()
    |> :erlang.md5()
    |> Base.encode64()
  end

  defp do_post_request(url, prepared_body, headers, options \\ []) do
    encoded_body = Jason.encode!(prepared_body)

    case HTTPoison.post(url, encoded_body, headers, options) do
      {:ok, %Response{status_code: 200, body: body}} ->
        {:ok, body}
      any ->
        {:error, any}
    end
  end

  defp parse_body(body) do
    case Jason.decode(body) do
      {:ok, %{"paymentId" => _id} = body} ->
        {:ok, %{
          "payment_id" => body["paymentId"],
          "pay_with_pay_phone_url" => body["payWithPayPhone"],
          "pay_with_card_url" => body["payWithCard"]
        }}

      {:ok, %{"statusCode" => _code} = body} ->
        {:ok, body}


      {:error, any} ->
        {:error, any}
    end
  end

  defp handle_error(error_reason) do
    {:error, inspect(error_reason)}
  end

  defp save_result(result, payment_data) do
    data_for_save = %{
      "payment_id" => result["payment_id"],
      "amount" => payment_data["amount"],
      "tax" => payment_data["tax"]
    }

    Payments.create_payment(data_for_save)
  end

  defp put_status(result, payment_id) do
    {:ok, payment} = Payments.get_payment_by_payment_id(payment_id)
    data_for_save = %{
      "status" => result["statusCode"]
    }

    Payments.update_payment(payment, data_for_save)
  end
end