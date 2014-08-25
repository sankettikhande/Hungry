class AddColumnMealFromTimeMealToTimeToCookingTodays < ActiveRecord::Migration
  def change
    add_column :cooking_todays, :meal_from_time, :time
    add_column :cooking_todays, :meal_to_time, :time
  end
end
