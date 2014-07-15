class CheffCuisineStyle < ActiveRecord::Base
  belongs_to :cheff
  belongs_to :cuisine_style

  attr_accessible :cheff_id, :cuisine_style_id



end