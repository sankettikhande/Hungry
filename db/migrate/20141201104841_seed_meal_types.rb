class SeedMealTypes < ActiveRecord::Migration
  def up
  	MealType.create([{ name: 'Breakfast', from: '12:00 AM', to: '11:00 AM', from_display: '12:00 AM', to_display: '11:00 AM', first_slot: ' 8AM -  9AM', second_slot: ' 9AM - 10AM', third_slot: '10AM - 11AM', is_active: false }])
	MealType.create([{ name: 'Lunch', from: '12:00 AM', to: '04:00 PM', from_display: '12:00 AM', to_display: '04:00 PM', first_slot: '12PM -  1PM', second_slot: ' 1PM -  2PM', third_slot: ' 2PM -  3PM', is_active: true }])
	MealType.create([{ name: 'Dinner', from: '12:00 AM', to: '11:00 PM', from_display: '08:00 PM', to_display: '11:00 PM', first_slot: ' 8PM -  9PM', second_slot: ' 9PM - 10PM', third_slot: '10PM - 11PM', is_active: true }])
	MealType.create([{ name: 'All Time', from: '12:00 AM', to: '11:00 PM', from_display: '12:00 AM', to_display: '11:00 PM', first_slot: ' 8AM -  9AM', second_slot: ' 9AM - 10AM', third_slot: '10AM - 11AM', is_active: false }])
  end

  def down
  end
end