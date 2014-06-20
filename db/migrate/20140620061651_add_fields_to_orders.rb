class AddFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :order_type, :string
    add_column :orders, :from_time, :time
    add_column :orders, :upto_time, :time
  end
end
