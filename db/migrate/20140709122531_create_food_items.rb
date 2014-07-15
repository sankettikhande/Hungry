class CreateFoodItems < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "FoodItem", :group_name => "FoodItem")
    create_content_table :food_items, :prefix=>false do |t|
      t.date :meal_acquired_date

      t.timestamps
    end
  end
end
