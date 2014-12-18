class ApiV2::OrdersController < ApiController
  def index
    @orders = Order.order_items_list(params[:from_date], params[:to_date])
  end
end
