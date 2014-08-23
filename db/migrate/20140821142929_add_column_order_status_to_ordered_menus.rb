class AddColumnOrderStatusToOrderedMenus < ActiveRecord::Migration
  def change
    add_column :ordered_menus, :order_status, :string, default: "Ordered"
  end
end
