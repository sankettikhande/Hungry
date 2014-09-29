class AddColumnDeliverySlotToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_slot, :string
  end
end
