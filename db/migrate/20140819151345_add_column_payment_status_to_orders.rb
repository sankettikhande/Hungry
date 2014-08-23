class AddColumnPaymentStatusToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_status, :string, default: "Waiting for Payment"
  end
end
