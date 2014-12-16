class ApiV2::OrdersController < ApplicationController
  def index
    @orders = Order.order_items_list(params[:from_date], params[:to_date])
  end
end
