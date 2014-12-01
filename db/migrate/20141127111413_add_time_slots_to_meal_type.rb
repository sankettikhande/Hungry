class AddTimeSlotsToMealType < ActiveRecord::Migration
  def change
  	add_content_column :meal_types, :first_slot, :string, null: false
  	add_content_column :meal_types, :second_slot, :string, null: false
  	add_content_column :meal_types, :third_slot, :string, null: false  	
  end
end
