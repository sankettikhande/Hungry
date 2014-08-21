class AddColumnReturnReasonToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :return_reason, :string
  end
end
