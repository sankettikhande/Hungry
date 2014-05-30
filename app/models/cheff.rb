class Cheff < ActiveRecord::Base
  acts_as_content_block

  has_many :dishes
  has_many :cooking_todays
  has_attached_file :cheff_image

  attr_accessible :cheff_image

  validates :name, :presence => true
end
