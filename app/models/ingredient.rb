class Ingredient < ActiveRecord::Base
  attr_accessible :ingredient_name, :quantity, :special_remarks, :unit, :sub_heading, :sub_menu_id
  belongs_to :sub_menu
end
