class OrderHistoriesController < ApplicationController
  def index
    hola_user = hola_current_user
    ordered_menus = hola_user.blank? ? [] : hola_user.orders.where("order_status != ? && mrp != ?","Created", 0).includes({:ordered_menus =>[{:food_item => {:meal_info => :picture}}, {:cheff => :chef_coordinate}]}).order("id desc").limit(50)
    @order_histories = ordered_menus.empty? ? [] : ordered_menus.flatten
  end
end
