class Ingredient < ActiveRecord::Base
  attr_accessible :ingredient_name, :quantity, :special_remarks
  belongs_to :dish
end
