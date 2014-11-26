class MealType < ActiveRecord::Base
	acts_as_content_block({:versioned => false})

  	attr_accessible :name, :from, :to, :is_active
end
