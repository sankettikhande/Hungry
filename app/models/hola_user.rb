class HolaUser < ActiveRecord::Base
  has_many :hola_user_addresses
  has_many :my_favorite_chefs
  has_many :my_favorite_recipes
  attr_accessible :name, :phoneNumber

  validates :phoneNumber, :uniqueness => true

  def self.add_to_favorite(hola_user, chef_id)
    fav_chef = MyFavoriteChef.where(:hola_user_id => hola_user.id, :cheff_id => chef_id)
    if fav_chef.blank?
      MyFavoriteChef.create(:hola_user_id => hola_user.id, :cheff_id => chef_id)
      success = true
    else
      fav_chef.delete_all
      success = false
    end
    return success
  end

  def self.add_recipe_to_favorite(hola_user, chef_id)
    fav_chef = MyFavoriteRecipe.where(:hola_user_id => hola_user.id, :food_item_id => chef_id)
    if fav_chef.blank?
      MyFavoriteRecipe.create(:hola_user_id => hola_user.id, :food_item_id => chef_id)
      success = true
    else
      fav_chef.delete_all
      success = false
    end
    return success
  end

  def self.most_popular_recipes
     FoodItem.order("dish_served desc").limit(10)
  end

end
