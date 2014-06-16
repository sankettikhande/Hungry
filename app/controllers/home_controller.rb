class HomeController < ApplicationController
  include ApplicationHelper
  before_filter :landing, :only => [:index]

  def landing
    if session[:landing].nil?
      session[:landing] = "landing"
      respond_to do |format|
        format.html{render :template =>  'home/landing' ,:layout => 'landing'}
      end
    else
      return
    end

  end

  def index
    @title = "Today's Menu"
    @todays_menu = CookingToday.where(:date => Date.today)
    update_cart(@todays_menu) if !@todays_menu.blank?
  end

  private
  def update_cart(todays_menu)
    return if todays_menu.blank?
    todays_ids = todays_menu.map(&:id)
    session[:cart] = [] if session[:cart].blank?
    cart_keys = session[:cart].collect{|item| item.keys}.flatten
    cart_keys = cart_keys.collect{|i| i.to_i}
    session[:cart].each do |item|
      session[:cart].delete(item) if cart_keys.any? {|cart_key| not todays_ids.include?(cart_key.to_i) }
    end
  end
end
