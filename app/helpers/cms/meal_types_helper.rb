module Cms::MealTypesHelper
	def set_selected(meal_type, i, key, time_type) 
    time_slot_field_name = "#{get_slot_number_string(i).downcase}_slot"
    time_for_time_slot = meal_type.send(time_slot_field_name)
    time_for_time_slot_split = time_for_time_slot.split("-")

    return "selected" if time_type == 'to_time' and time_for_time_slot_split.last.strip == key
    return "selected" if time_type == 'from_time' and time_for_time_slot_split.first.strip == key
  end

  def get_slot_number_string i
    {1 => "First", 2 => "Second", 3 => "Third", 4 => "Fourth", 5 => "Fifth", 6 => "Sixth"}[i]
  end
end
