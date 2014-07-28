class AddDishServedToFoodItems < ActiveRecord::Migration
  def change
    add_column :food_items, :dish_served, :integer, default: 0
  end
end
