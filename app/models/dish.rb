class Dish < ActiveRecord::Base
  acts_as_content_block

  belongs_to :cheff, foreign_key: :cheff_id
  has_many :cooking_todays
  has_many :ordered_menus
  has_attached_file :dish_image

  attr_accessible :dish_image


  validates :name, :presence => true
  validates :cheff_id, :presence => true
end
