class AddRecipeIdToSubMenu < ActiveRecord::Migration
  def change
    add_column :sub_menus, :recipe_id, :integer
  end
end
