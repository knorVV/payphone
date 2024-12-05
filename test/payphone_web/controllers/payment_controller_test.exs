defmodule PayphoneWeb.PaymentControllerTest do
  # use PayphoneWeb.ConnCase

  # alias Payphone.Payments

  # @create_attrs %{
  #   "payment_id" => "ROquezy4tkWbtrOR2tpLRw",
  #   "amount" => 100,
  #   "tax" => 2
  # }
  # @update_attrs %{
  #   "status" => 3
  # }
  # @invalid_attrs %{
  #   "amount" => 100,
  #   "tax" => 2
  # }

  # def fixture(:payment) do
  #   {:ok, payment} = Payments.create_payment(@create_attrs)
  #   payment
  # end

  # setup %{conn: conn} do
  #   {:ok, conn: put_req_header(conn, "accept", "application/json")}
  # end

  # describe "create payment" do
  #   test "create", %{conn: conn} do
  #     conn = post(conn, Routes.payment_path(conn, :create), @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.payment_path(conn, :show, id))

  #     assert %{
  #              "id" => id
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.payment_path(conn, :create), payment: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "handle_response" do
  #   setup [:create_payment]

  #   test "renders payment when data is valid", %{conn: conn, payment: %Payment{id: id} = payment} do
  #     conn = put(conn, Routes.payment_path(conn, :handle_response, payment), payment: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.payment_path(conn, :show, id))

  #     assert %{
  #              "id" => id
  #            } = json_response(conn, 200)["data"]
  #   end
  # end

  # defp create_payment(_) do
  #   payment = fixture(:payment)
  #   %{payment: payment}
  # end
end
