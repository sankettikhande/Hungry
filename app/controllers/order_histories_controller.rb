class OrderHistoriesController < ApplicationController
  def index
    hola_user = HolaUser.find_by_phoneNumber(cookies[:user_mobile]) if cookies[:user_mobile].present?
    ordered_menus = hola_user.orders.map{|order| order.ordered_menus }
    @order_histories = ordered_menus.empty? ? [] : ordered_menus.flatten
  end
end
