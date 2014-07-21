class AddFoodItemIdToCookingToday < ActiveRecord::Migration
  def change
    add_column :cooking_todays, :food_item_id, :integer
  end
end
