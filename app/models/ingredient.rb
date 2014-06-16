class Ingredient < ActiveRecord::Base
  attr_accessible :ingredient_name, :quantity, :special_remarks, :unit, :sub_heading
  belongs_to :dish
end
