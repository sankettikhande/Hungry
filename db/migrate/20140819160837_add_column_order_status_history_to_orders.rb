class AddColumnOrderStatusHistoryToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_status_history, :string
  end
end
