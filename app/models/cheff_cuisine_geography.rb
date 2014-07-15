class CheffCuisineGeography < ActiveRecord::Base
  belongs_to :cheff
  belongs_to :cuisine_geography

  attr_accessible :cheff_id, :cuisine_geography_id
end
