class AddSpecialityOfDishToMealInfos < ActiveRecord::Migration
  def change
    add_column :meal_infos, :speciality_of_dish, :string unless column_exists?(:meal_infos, :speciality_of_dish)
  end
end
