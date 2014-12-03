class AddAdditionalSlotsToMealTypes < ActiveRecord::Migration
  def change
  	add_column :meal_types, :fourth_slot, :string
  	add_column :meal_types, :fifth_slot, :string
  	add_column :meal_types, :sixth_slot, :string 
  	add_column :meal_types, :fourth_slot_active, :boolean, :default => false
  	add_column :meal_types, :fifth_slot_active, :boolean, :default => false
  	add_column :meal_types, :sixth_slot_active, :boolean, :default => false
  end
end
