class Api::OrdersController < ApiController
  def index
    @orders = Order.where("DATE(created_at) = '#{Date.today}'")
  end

  def show
    @order = Order.find params[:id]
  end

  def update_status
    @order = Order.find params[:order_id]
    @order.order_status = params[:status]
    @order.return_reason = "#{params[:status]}- #{params[:reason]}" unless params[:reason].blank?
    if @order.save
      @message = "Order status updated"
      render "api/success"
    else
      @message = @order.errors.full_messages
      render "api/failure"
    end
  end

  def assign_runner
    @order = Order.find params[:order_id]
    @order.runner_id = params[:runner_id]
    if @order.save
      @message = "Order status updated"
      render "api/success"
    else
      @message = @order.errors.full_messages
      render "api/failure"
    end
  end

end
