class CreateMealTypes < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "MealType", :group_name => "MealType")
    create_content_table :meal_types, :prefix=>false do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.string :from_display, null: false
      t.string :to_display, null: false
      t.string :first_slot, null: false, :default => ' 8AM -  9AM'
      t.string :second_slot, null: false, :default => ' 9AM - 10AM'
      t.string :third_slot, null: false, :default => '10AM - 11AM'
      t.boolean :is_active, :default => false

      t.timestamps
    end
  end
end