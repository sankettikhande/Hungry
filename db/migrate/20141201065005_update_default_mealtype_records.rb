class UpdateDefaultMealtypeRecords < ActiveRecord::Migration
  def up
  	MealType.find_by_name('Breakfast').update_attributes(from: '12:00 AM', to: '11:00 AM', from_display: '12:00 AM', to_display: '11:00 AM')
	MealType.find_by_name('Lunch').update_attributes(from: '12:00 AM', to: '04:00 PM', from_display: '12:00 AM', to_display: '04:00 PM', is_active: true)
	MealType.find_by_name('Dinner').update_attributes(from: '12:00 AM', to: '11:00 PM', from_display: '08:00 PM', to_display: '11:00 PM', is_active: true)
	MealType.find_by_name('All Time').update_attributes(from: '12:00 AM', to: '11:00 PM', from_display: '12:00 AM', to_display: '11:00 PM')
  end

  def down
  end
end
