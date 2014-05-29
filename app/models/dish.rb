class Dish < ActiveRecord::Base
  acts_as_content_block

  belongs_to :cheff, foreign_key: :cheff_id
  has_attached_file :dish_image

  attr_accessible :dish_image


  validate :name, :presence => true
  validate :cheff_id, :presence => true
end
