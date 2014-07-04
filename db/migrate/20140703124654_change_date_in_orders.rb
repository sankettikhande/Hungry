class ChangeDateInOrders < ActiveRecord::Migration
  def up
    change_column :orders, :date, :date
  end
end
