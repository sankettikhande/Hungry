class MealType < ActiveRecord::Base
	acts_as_content_block({:versioned => false})

  	attr_accessible :name, :from, :to, :is_active
  	attr_accessor :skip_callbacks

  	validates_presence_of :name, :from, :to
    validates :name, uniqueness: true

   	before_save :reset_name, :if => Proc.new {|mt| ['Breakfast', 'Lunch', 'Dinner', 'All Time'].include?(mt.name_was) }
  
   	scope :active_meal_type, lambda{ where(:is_active => true) }

   	def reset_name  
   		self.name = self.name_was
   	end 	
end