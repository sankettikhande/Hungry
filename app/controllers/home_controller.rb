class HomeController < ApplicationController
  include ApplicationHelper

  #before_filter :prepare_for_mobile
  # before_filter :landing, :only => [:index]
  #skip_before_filter :prepare_for_mobile, :only => [:desktop]

  before_filter :set_cache_buster, :only => [:mobile]
  before_filter :set_mobile_request_flag, :only => [:mobile]

  def landing

    # if session[:landing].nil?
    #   session[:landing] = "landing"
    #   respond_to do |format|
    #     format.html{render :template =>  'home/landing' ,:layout => 'landing'}

    #   end
    #   #return if !session[:landing].nil?
    # end
    render layout: 'landing'
  end

  def index
    if cookies.signed[:returning_user]
      cookies.signed[:returning_user] = true
      redirect_to "/mobile"
    else
      redirect_to "/landing"
    end
  end

  def mobile

    # @todays_menu = CookingToday.grouped_by_category
    @sunday_override = params[:sunday_override]
    update_cart(@todays_menu) if !@todays_menu.blank?
    @todays_menu_by_meal_type = get_todays_menu_by_meal_type
    respond_to do |format|
      format.html{render template: "home/index"}
    end
  end

  def desktop
    render :layout => false
  end

  def feedback
    @feedback = Feedback.new(feedback: params[:feedback], email: params[:email])
    flash[:notice] = "Thanks!! Feedback received." if @feedback.save
    respond_to do |format|
      format.html{ render :template => "hola_users/talk_to_us"}
    end
  end

  def add_other_dishes
    @remaining_categories = CookingToday.joins(food_item: :recipe).where('recipes.category' => params[:category]).sorted_by_qty_left
    respond_to do |format|
      format.html{render :layout => 'application'}
    end
  end

  def logout
   session.clear
   cookies.delete :user_mobile
   redirect_to("/mobile") and return
  end

  def how_it_works
    render :layout => false
  end

  def service_areas
    render :layout => false
  end

  def service_area_map
    render :layout => false
  end

  private
  def update_cart(todays_menu)
    return if todays_menu.blank?
    todays_menu = todays_menu.values.flatten
    todays_ids = todays_menu.map(&:id)
    session[:cart] = [] if session[:cart].blank?
    cart_keys = session[:cart].collect{|item| item.keys}.flatten
    cart_keys = cart_keys.collect{|i| i.to_i}
    session[:cart].each do |item|
      session[:cart].delete(item) if cart_keys.any? {|cart_key| not todays_ids.include?(cart_key.to_i) }
    end
  end

  def get_todays_menu_by_meal_type
    menu_by_meal_type = {}
    CookingToday.meal_types_name.each do |meal_type|
      menu_by_meal_type.merge!(meal_type => CookingToday.todays_menu_by_type(meal_type))
    end
    all_time_meal = menu_by_meal_type.delete("All Time") || []

    menu_by_meal_type.each do |meal_type, meal_items|
      menu_by_meal_type[meal_type] = meal_items + all_time_meal
    end

    menu_by_meal_type
  end

  def set_mobile_request_flag
    session[:app_request] = true unless params[:app_request].blank?
  end
end
