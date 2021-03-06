class ChefProfile < ActiveRecord::Base
  belongs_to :cheff
  attr_accessible :cheff_id, :about_me, :why_i_love_cooking, :people_places_that_inspire_my_food, :best_compliment,
                  :why_do_i_want_to_join_hola, :facebook_handle, :twitter_handle, :banners, :brand_represented,
                  :brand_info, :brand_banner, :classification
  validates_presence_of :about_me
  validates_presence_of :brand_represented
  validates_presence_of :classification
end
