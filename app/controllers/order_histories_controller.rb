class OrderHistoriesController < ApplicationController
  def index
    hola_user = hola_current_user
    hola_current_user = hola_user.blank? ? [] : hola_user.orders.where("order_status IN (?) && mrp != ?",["Dispatched", "Delivered"], 0).includes({:ordered_menus =>[{:food_item => {:meal_info => :picture}}, {:cheff => :chef_coordinate}]}).order("id desc").limit(50)
    @order_histories = hola_current_user.empty? ? [] : hola_current_user.flatten
  end
end
