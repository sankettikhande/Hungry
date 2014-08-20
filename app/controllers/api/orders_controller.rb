class Api::OrdersController < ApiController
  after_filter do |controller|
    if controller.params[:callback] && controller.params[:format].to_s == 'json'
      controller.response['Content-Type'] = 'application/javascript'
      controller.response.body = "%s(%s)" % [controller.params[:callback], controller.response.body]
    end
  end

  def index
    @orders = Order.where("DATE(created_at) = '#{Date.today}'")
  end

  def show
    @order = Order.find params[:id]
  end

  def update_status
    @order = Order.find params[:order_id]
    @order.order_status = params[:status]
    if @order.save
      @message = "Order status updated"
      render "api/success"
    else
      @message = @order.errors.full_messages
      render "api/failure"
    end
  end

end
