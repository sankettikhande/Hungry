class HolaUser < ActiveRecord::Base
  has_one_time_password
  has_many :hola_user_addresses
  has_many :my_favorite_chefs
  has_many :my_favorite_recipes
  has_many :orders
  has_and_belongs_to_many :coupons, :join_table => "hola_user_coupons", :foreign_key => "hola_user_id"
  attr_accessible :name, :email, :phoneNumber

  validates :phoneNumber, uniqueness: true, presence: true

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
    HolaUser.find_by_phoneNumber(options[:phone_no]) || HolaUser.create(:name => options[:name], :phoneNumber => options[:phone_no], :email => options[:email])
  end

  def get_default_address
    hola_user_addresses.default_address.first
  end

  def self.confirm_orders_last_3_days(hola_user_id)
    hola_user = HolaUser.find_by_id(hola_user_id)
    return hola_user.orders.confirm_orders.where("date >= ? and date <= ?",3.days.ago, Date.today).count
  end

end
