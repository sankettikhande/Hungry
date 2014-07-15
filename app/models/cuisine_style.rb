class CuisineStyle < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks
  has_many :cheffs
  has_many :cheffs, :through => :cheff_cuisine_styles
end
