class AddFieldsToMealTypesForSlotActivation < ActiveRecord::Migration
  def change
  	add_column :meal_types, :first_slot_active, :boolean, :default => true
  	add_column :meal_types, :second_slot_active, :boolean, :default => true
  	add_column :meal_types, :third_slot_active, :boolean, :default => true
  end
end
