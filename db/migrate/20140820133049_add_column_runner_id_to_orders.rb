class AddColumnRunnerIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :runner_id, :integer
  end
end
