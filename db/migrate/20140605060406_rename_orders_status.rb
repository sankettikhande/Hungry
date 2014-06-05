class RenameOrdersStatus < ActiveRecord::Migration
  def up
    rename_column :orders, :status, :order_status
    rename_column :order_versions, :status, :order_status
  end

  def down
  end
end
