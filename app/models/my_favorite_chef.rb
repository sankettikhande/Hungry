class MyFavoriteChef < ActiveRecord::Base
  belongs_to :cheff
  belongs_to :hola_user

  attr_accessible :hola_user_id, :cheff_id
end
