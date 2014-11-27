class AddFieldsToMealType < ActiveRecord::Migration
  def change
  	add_content_column :meal_types, :from_display, :string, null: false
  	add_content_column :meal_types, :to_display, :string, null: false
  end
end
