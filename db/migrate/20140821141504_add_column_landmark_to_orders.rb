class AddColumnLandmarkToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :landmark, :string
  end
end
