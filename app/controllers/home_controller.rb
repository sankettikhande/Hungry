
class HomeController < ApplicationController
  include ApplicationHelper

  #before_filter :prepare_for_mobile
  before_filter :landing, :only => [:index]
  #skip_before_filter :prepare_for_mobile, :only => [:desktop]

  def landing
    if session[:landing].nil?
      session[:landing] = "landing"
      respond_to do |format|
        format.html{render :template =>  'home/landing' ,:layout => 'landing'}

      end
      #return if !session[:landing].nil?
    end

  end

  def index
    @todays_menu = CookingToday.grouped_by_category
    update_cart(@todays_menu) if !@todays_menu.blank?

    respond_to do |format|
      format.html
    end
  end

  def mobile
    @todays_menu = CookingToday.grouped_by_category
    update_cart(@todays_menu) if !@todays_menu.blank?

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
end
