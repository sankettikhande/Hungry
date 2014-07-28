class MyFavoriteRecipe < ActiveRecord::Base
  belongs_to :food_item
  belongs_to :hola_user

  attr_accessible :hola_user_id, :food_item_id
end
