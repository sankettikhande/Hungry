class AddColumnPaymentModeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :payment_mode, :string
  end
end
