class FoodItem < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  belongs_to :cheff
  has_many :ordered_menus

  attr_accessible :meal_info_attributes, :recipe_attributes, :review_attributes, :cooking_todays

  has_one :meal_info, :dependent => :destroy
  has_one :recipe, :dependent => :destroy
  # has_one :review, :dependent => :destroy
  has_many :reviews, :dependent => :destroy
  has_many :cooking_todays

  accepts_nested_attributes_for :meal_info
  accepts_nested_attributes_for :recipe
  # accepts_nested_attributes_for :review

  validates_presence_of :cheff_id

  scope :signature_dish, where("if_signature = true")

  def name
    "Meal Name: #{self.meal_info.name} " if self.meal_info
  end

  def has_picture?
    meal_info.picture rescue nil
  end

  def average_rating
    reviews.count > 0 ? reviews.sum(:ratings)/reviews.count : 0
  end

  def user_rating user
    reviews.where(hola_user_id: user.id).first
  end

end
