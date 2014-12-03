class Cms::MealTypesController < Cms::ContentBlockController
	def create
		params[:meal_type][:first_slot] = params[:from_slot_1] + ' - ' + params[:to_slot_1]
		params[:meal_type][:second_slot] = params[:from_slot_2] + ' - ' + params[:to_slot_2]
		params[:meal_type][:third_slot] = params[:from_slot_3] + ' - ' + params[:to_slot_3]
		params[:meal_type][:fourth_slot] = params[:from_slot_4] + ' - ' + params[:to_slot_4]
		params[:meal_type][:fifth_slot] = params[:from_slot_5] + ' - ' + params[:to_slot_5]
		params[:meal_type][:sixth_slot] = params[:from_slot_6] + ' - ' + params[:to_slot_6]

		@meal_type = MealType.create(params[:meal_type])
    	if @meal_type.save      
      		redirect_to '/cms/meal_types', :notice => "Successfully created meal type."
    	else
      		render :action => 'new'
    	end				
	end

	def edit
	 	@meal_type  = MealType.find(params[:id])
     	respond_to do |format|
       		format.html
     	end
	end

	def update
		@meal_type = MealType.find(params[:id])

		if params[:slot_updated] == 'true'
			params[:meal_type][:first_slot] = params[:from_slot_1] + ' - ' + params[:to_slot_1]
			params[:meal_type][:second_slot] = params[:from_slot_2] + ' - ' + params[:to_slot_2]
			params[:meal_type][:third_slot] = params[:from_slot_3] + ' - ' + params[:to_slot_3]
			params[:meal_type][:fourth_slot] = params[:from_slot_4] + ' - ' + params[:to_slot_4]
			params[:meal_type][:fifth_slot] = params[:from_slot_5] + ' - ' + params[:to_slot_5]
			params[:meal_type][:sixth_slot] = params[:from_slot_6] + ' - ' + params[:to_slot_6]

		else
			params[:meal_type][:first_slot] = @meal_type.first_slot
			params[:meal_type][:second_slot] = @meal_type.second_slot
			params[:meal_type][:third_slot] = @meal_type.third_slot
			params[:meal_type][:fourth_slot] = @meal_type.fourth_slot 
			params[:meal_type][:fifth_slot] = @meal_type.fifth_slot
			params[:meal_type][:sixth_slot] = @meal_type.sixth_slot
		end
		
    	if @meal_type.update_attributes(params[:meal_type])      
      		redirect_to '/cms/meal_types', :notice => "Successfully added meal type."
    	else
      		render :action => 'edit'
    	end				
	end
end