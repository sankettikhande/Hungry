class Recipe < ActiveRecord::Base
  belongs_to :food_item

  attr_accessible :dish_type, :if_signature, :if_recipe, :cuisine, :category, :treatment, :garnishing_tips, :serving_tips, :storage_instructions, :shelf_life,
                  :equipment_required, :preparation_time, :total_time, :servings,
                  :picture_attributes, :sub_menus_attributes

  has_many :sub_menus, :dependent => :destroy
  accepts_nested_attributes_for :sub_menus, :reject_if => :all_blank, :allow_destroy => true

  #validates_presence_of :dish_type
end
