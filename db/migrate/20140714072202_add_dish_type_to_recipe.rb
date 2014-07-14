class AddDishTypeToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :dish_type, :string
  end
end
