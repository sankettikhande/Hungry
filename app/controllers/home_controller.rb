class HomeController < ApplicationController
  include ApplicationHelper
  def index
    @todays_menu = CookingToday.where(:date => Date.today)
    update_cart(@todays_menu)
    @cheff_pp = Cheff.find(:all,:order => 'id')
  end

  private
  def update_cart(todays_menu)
    todays_ids = todays_menu.collect(&:id)
    cart_keys = session[:cart].collect{|item| item.keys}.flatten
    cart_keys = cart_keys.collect{|i| i.to_i}
    session[:cart].each do |item|
      session[:cart].delete(item) if cart_keys.any? {|cart_key| not todays_ids.include?(cart_key.to_i) }
    end
  end
end
