class FoodItem < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  belongs_to :cheff

  attr_accessible :meal_info_attributes, :recipe_attributes, :review_attributes

  has_one :meal_info, :dependent => :destroy
  has_one :recipe, :dependent => :destroy
  has_one :review, :dependent => :destroy

  accepts_nested_attributes_for :meal_info
  accepts_nested_attributes_for :recipe
  accepts_nested_attributes_for :review

  validates_presence_of :cheff_id

  def name
    "Meal Name: #{self.meal_info.name} " if self.meal_info
  end

end
