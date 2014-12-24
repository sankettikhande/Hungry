class AddColumnRedFlagToFoodItems < ActiveRecord::Migration
  def change
    add_column :food_items, :red_flag, :boolean, :default => false
  end
end
