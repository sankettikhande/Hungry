class HolaUser < ActiveRecord::Base
  has_many :hola_user_addresses
  has_many :my_favorite_chefs
  has_many :my_favorite_recipes
  has_many :orders
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

  def self.most_popular_signature_dishes
    FoodItem.where(:if_signature => true).order("dish_served desc").limit(10)
  end

  def favorite_signature_dishes
    fav_dishes = []
    self.my_favorite_recipes.each do |fav_recipe|
      food_item = fav_recipe.food_item
      fav_dishes << food_item if food_item.if_signature
    end
    return fav_dishes
  end

  def self.create_from_params options
    hola_user = HolaUser.find_by_phoneNumber(options[:phone_no])
    if hola_user
      hola_user.update_attributes(:name => options[:name], :phoneNumber => [:phone_no])
      #HolaUserAddress.create(:address => options[:address], :hola_user_id => hola_user.id) if !hola_user.hola_user_addresses.map(&:address).include?(options[:address].strip)
    else
      hola_user = HolaUser.create(:name => options[:name], :phoneNumber => options[:phone_no])
      #HolaUserAddress.create(:address => options[:address].strip, :hola_user_id => hola_user.id)  if hola_user
    end
    return hola_user
  end

  def get_default_address
    hola_user_addresses.default_address.first
  end
end
