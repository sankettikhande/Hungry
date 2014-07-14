class AddTimeToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :preparation_time, :integer
    add_column :recipes, :total_time, :integer
    add_column :recipes, :servings, :integer
  end
end
