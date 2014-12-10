class MealType < ActiveRecord::Base
	acts_as_content_block({:versioned => false})

  	attr_accessible :name, :from, :to, :is_active, :from_display, :to_display, :first_slot, :second_slot, :third_slot
  	attr_accessor :skip_callbacks

  	validates :name, :from, :to, :from_display, :to_display, presence: true
    validates :name, uniqueness: true
    
    validates :first_slot, :second_slot, :third_slot, length: {
      minimum: 1,
      too_short: "Please add delivery slot"    
    }

   	before_save :reset_name, :if => Proc.new {|mt| ['Breakfast', 'Lunch', 'Dinner', 'All Time'].include?(mt.name_was) }
  
   	scope :active_meal_type, lambda{ where(:is_active => true) }

   	def reset_name  
   		self.name = self.name_was
   	end 	
end
