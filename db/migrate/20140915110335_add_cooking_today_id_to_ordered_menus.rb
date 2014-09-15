class AddCookingTodayIdToOrderedMenus < ActiveRecord::Migration
  def change
  	add_column :ordered_menus, :cooking_today_id, :integer
  end
end
