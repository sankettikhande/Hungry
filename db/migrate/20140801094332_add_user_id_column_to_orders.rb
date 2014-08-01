class AddUserIdColumnToOrders < ActiveRecord::Migration
  def change
  	add_column :orders, :hola_user_id, :integer
  end
end
