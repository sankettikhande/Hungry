class ChangeColumnMealFromTimeAndMealToTime < ActiveRecord::Migration
  def up
    change_column :cooking_todays, :meal_from_time, :datetime
    change_column :cooking_todays, :meal_to_time, :datetime
  end

  def down
  end
end
