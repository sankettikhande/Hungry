class AddSignatureToFoodItem < ActiveRecord::Migration
  def change
    add_column :food_items, :if_signature, :boolean, :default => false
    add_column :food_items, :if_recipe, :boolean, :default => false
  end
end
