class OrderHistoriesController < ApplicationController
  def index
    hola_user = hola_current_user
    ordered_menus = hola_user.blank? ? [] : hola_user.orders.map{|order| order.ordered_menus }
    @order_histories = ordered_menus.empty? ? [] : ordered_menus.flatten
  end
end
