class AddColumnReorderIdOriginalOrderIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :reorder_id, :integer
    add_column :orders, :original_order_id, :integer
  end
end
