class AddColumnParentOrderIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :parent_order_id, :integer
  end
end
