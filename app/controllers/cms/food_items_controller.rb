require 'will_paginate/array'
class Cms::FoodItemsController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:show_recipe, :signature_dishes, :update_ratings, :post_review]

  def index
    if !params[:search].blank? && !params[:search][:term].blank?
      @food_items = FoodItem.find(:all, :include => :meal_info, :conditions => ["meal_infos.name LIKE ?", "%#{params[:search][:term]}%"]).paginate(:per_page => 10, :page => params[:page])
      if @food_items.blank?
          @chef = Cheff.find(:first, :include => :chef_coordinate, :conditions => ["chef_coordinates.name LIKE ?", "%#{params[:search][:term]}%"])
          @food_items = FoodItem.find(:all, :include => :cheff, :conditions => ["cheffs.id = ?", @chef.id]).paginate( :per_page => 10, :page => params[:page]) if @chef
      end
    else
      @food_items = FoodItem.find(:all, :include => :cheff).paginate( :per_page => 10, :page => params[:page])
    end
    respond_to do |format|
      format.html
    end
  end

  def load_chef_dishes
    @chef = Cheff.find(params[:cheff_id])
    @food_items = FoodItem.find(:all, :include => :cheff, :conditions => ["cheffs.id = ?", @chef.id]) if @chef
  end

  def show_recipe
    # @footer = "false"
    @food_item = FoodItem.find(params[:id]) if !params[:id].blank?
    @cooking_today = CookingToday.where(:food_item_id =>@food_item.id, :date => Date.today).first if @food_item
    respond_to do |format|
      format.html { render :layout=>'application' }
    end
  end

  def signature_dishes
    @signature_dish = FoodItem.find_by_id(params[:dish_name])
    respond_to do |format|
      format.html { render :layout => 'application' }
    end
  end

  def new
    @food_item = FoodItem.new
    @food_item.build_recipe
    @food_item.recipe.sub_menus.build
    @food_item.build_meal_info
    # @food_item.build_review
    respond_to do |format|
      format.html
    end
  end

  def edit
    @food_item = FoodItem.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def create
    @food_item = FoodItem.new(params[:food_item])
    @food_item.meal_info.is_signature = @food_item.if_signature
    if @food_item.save
      redirect_to '/cms/food_items', :notice => "Successfully created Food Item."
    else
      render :action => 'new'
    end
  end

  def update
    @food_item = FoodItem.find(params[:id])
    @food_item.meal_info.is_signature = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(params[:food_item][:if_signature])
    if @food_item.update_attributes(params[:food_item])
      flash[:notice] = "Successfully updated Food Item."
      redirect_to '/cms/food_items', :notice => "Successfully created Food Item."
    else
      render :action => 'edit'
    end

  end

  def update_ratings
    if hola_current_user
      @food_item = FoodItem.find(params[:food_item_id], include: :reviews)
      food_item_review = @food_item.reviews.find_or_create_by_hola_user_id(hola_current_user.id)
      if food_item_review
        food_item_review.update_attributes(ratings: params[:food_item_ratings], review_date: Date.today)
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def delete_food_item
    @food_item = FoodItem.find(params[:id])
    if @food_item.destroy
      flash[:notice] = "Deleted food items successfully."
    else
      flash[:notice] = "No food items found."
    end
    redirect_to "/cms/food_items"
  end

  def post_review
    if hola_current_user
      @food_item = FoodItem.find(params[:food_item_id], include: :reviews)
      food_item_review = @food_item.reviews.find_or_create_by_hola_user_id(hola_current_user.id)
      if food_item_review
        food_item_review.update_attributes(review: params[:review])
      end
    end
    respond_to do |format|
      format.js
    end
  end


end
