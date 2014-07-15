class CuisineGeography < ActiveRecord::Base

  has_ancestry
  acts_as_content_block({:versioned => false})
  attr_accessible :parent_id
  attr_accessor :skip_callbacks
  has_many :cheff_cuisine_geographies
  has_many :cheffs, :through => :cheff_cuisine_geographies


end
