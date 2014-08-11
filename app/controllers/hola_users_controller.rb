class HolaUsersController < ApplicationController
  def add_chef_to_favorite
    hola_user = hola_current_user
    @add_to_fav = HolaUser.add_to_favorite(hola_user, params[:chef_id]) if hola_user
    respond_to do |format|
      format.js
    end
  end

  def my_favorite_chefs
    hola_user = hola_current_user
    @favorite_chefs = hola_user.my_favorite_chefs if hola_user
    respond_to do |format|
      format.html{ render :template => "hola_users/my_favorite_chefs"}
    end
  end

  def add_recipe_to_favorite
    hola_user = hola_current_user
    @add_to_fav = HolaUser.add_recipe_to_favorite(hola_user, params[:recipe_id]) if hola_user
    respond_to do |format|
      format.js
    end
  end

  def recipes
    if params[:recipe_name].present?
      @searched_recipe = FoodItem.joins("INNER JOIN meal_infos on meal_infos.food_item_id = food_items.id").where("meal_infos.name like ?", "%#{params[:recipe_name]}%") if params[:recipe_name]
    elsif params[:favorite].present?
      @recipes = hola_user.my_favorite_recipes if hola_user
    elsif params[:popular].present?
      @recipes = HolaUser.most_popular_recipes
    else
      @recipes = FoodItem.where(:if_recipe => true).includes(:meal_info)
    end
    respond_to do |format|
      format.html{ render :template => "hola_users/recipes"}
    end
  end

  def favourite_recipes
    hola_user = hola_current_user
    @recipes = hola_user.my_favorite_recipes.map(&:food_item) if hola_user
    render action: 'recipes'
  end

  def signature_dishes
    hola_user = hola_current_user
    if params[:dish].present?
      @searched_dish = FoodItem.joins("INNER JOIN meal_infos on meal_infos.food_item_id = food_items.id").where("meal_infos.name like ?", "%#{params[:dish]}%") if params[:dish]
    elsif params[:favorite].present?
      @signature_dishes = hola_user.favorite_signature_dishes if hola_user
    elsif params[:popular].present?
      @signature_dishes = HolaUser.most_popular_signature_dishes
    else
      @signature_dishes = FoodItem.where(:if_recipe => true).signature_dish
    end
    respond_to do |format|
      format.html{ render :template => "hola_users/signature_dishes"}
    end
  end

  def favourite_signature_dishes
    hola_user = hola_current_user
    @signature_dishes = hola_user.favorite_signature_dishes if hola_user
    render action: 'signature_dishes'
  end

  def talk_to_us

  end

end
