class AddColumnAddressIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :delivery_address_id, :integer
  end
end
