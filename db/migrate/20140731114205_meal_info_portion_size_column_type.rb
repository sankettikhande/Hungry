class MealInfoPortionSizeColumnType < ActiveRecord::Migration
  def up
  	change_column :meal_infos, :portion_size, :string
  end

  def down
  end
end
