module OrderedMenusHelper	

	def get_active_slots(meal_type_name)

		meal_type = MealType.find_by_name(meal_type_name)
		slots = []

		if meal_type.first_slot_active
			slots << meal_type.first_slot
		end

		if meal_type.second_slot_active
			slots << meal_type.second_slot
		end

		if meal_type.third_slot_active
			slots << meal_type.third_slot
		end

		if meal_type.fourth_slot_active
			slots << meal_type.fourth_slot
		end

		if meal_type.fifth_slot_active
			slots << meal_type.fifth_slot
		end

		if meal_type.sixth_slot_active
			slots << meal_type.sixth_slot
		end

		slots
	end

	def get_slot_active_time(slot)
		minutes = 0
		minutes = 45 if slot == '11PM - 11:30PM'
		
		Time.local(Time.now.year, Time.now.month, Time.now.day, TIME[slot.split("-").last.strip], minutes) - 15 * 60	
	end
end
