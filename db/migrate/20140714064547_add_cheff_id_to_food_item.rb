class AddCheffIdToFoodItem < ActiveRecord::Migration
  def change
    add_column :food_items, :cheff_id, :integer
  end
end
