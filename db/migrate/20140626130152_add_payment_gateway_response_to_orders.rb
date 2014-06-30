class AddPaymentGatewayResponseToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_gateway_response, :text
  end
end
