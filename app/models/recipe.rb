class Recipe < ActiveRecord::Base
  belongs_to :food_item

  attr_accessible :dish_type, :if_signature, :if_recipe, :cuisine, :category, :treatment, :garnishing_tips, :serving_tips, :storage_instructions, :shelf_life,
                  :equipment_required, :preparation_time, :total_time, :servings, :ingredients_attributes,
                  :prepration_steps_attributes, :picture_attributes

  has_many :ingredients, :dependent => :destroy
  accepts_nested_attributes_for :ingredients, :allow_destroy => true, :reject_if => :all_blank

  has_many :prepration_steps, :dependent => :destroy
  accepts_nested_attributes_for :prepration_steps, :allow_destroy => true, :reject_if => :all_blank

  validates_presence_of :dish_type
end
