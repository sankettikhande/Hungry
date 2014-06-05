class Cheff < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  has_many :dishes
  has_many :cooking_todays
  has_many :ordered_menus
  has_attached_file :cheff_image

  attr_accessible :cheff_image

  validates :name, :presence => true
end
