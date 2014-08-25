class AddColumnMealTypeToCookingTodays < ActiveRecord::Migration
  def change
    add_column :cooking_todays, :meal_type, :string
  end
end
