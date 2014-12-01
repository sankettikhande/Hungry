class CreateMealTypes < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "MealType", :group_name => "MealType")
    create_content_table :meal_types, :prefix=>false do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.string :from_display, null: false
      t.string :to_display, null: false
      t.string :first_slot, null: false, :default => ' 8AM -  9AM'
      t.string :second_slot
      t.string :third_slot
      t.boolean :is_active, :default => false

      t.timestamps
    end
  end
end