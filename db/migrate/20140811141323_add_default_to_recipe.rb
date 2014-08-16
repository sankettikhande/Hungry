class AddDefaultToRecipe < ActiveRecord::Migration
  def change
    change_column :food_items, :if_recipe, :boolean, :default => true
  end
end
