class CreateMealTypes < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "MealType", :group_name => "MealType")
    create_content_table :meal_types, :prefix=>false do |t|
      t.string :from, null: false
      t.string :to, null: false
      t.boolean :is_active, :default => false

      t.timestamps
    end

    # Default records
	MealType.create([{ name: 'Breakfast', from: '08:00', to: '10:00'}])
	MealType.create([{ name: 'Lunch', from: '11:00', to: '14:00', is_active: true}])
	MealType.create([{ name: 'Dinner', from: '19:00', to: '23:00', is_active: true}])
	MealType.create([{ name: 'All Time', from: '01:00', to: '23:00'}])
  end
end
