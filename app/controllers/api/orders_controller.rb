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

  def update_menu_item_status
    @order = Order.find params[:order_id]
    @order_menu = @order.ordered_menus.find(params[:order_menu_id])
    @order_menu.order_status = params[:status]

    if @order_menu.save
      @message = "Order menu status updated"
      render "api/success"
    else
      @message = @order_menu.errors.full_messages
      render "api/failure"
    end
  end

  def reorder
    @order = Order.find params[:order_id]
    new_order = @order.deep_clone include: :ordered_menus, validate: false
    new_order.original_order_id = @order.id
    new_order.order_status = "Confirmed"
    new_order.order_status_history = ["Created", "Confirmed"]
    new_order.original_order_id = @order.id
    if new_order.save
      @order.update_attributes(reorder_id: new_order.id, order_status: "Reordered")
      @message = {"msg" => "New order placed", "order_id" => new_order.id}
      render "api/success"
    else
      @message = new_order.errors.full_messages
      render "api/failure"
    end
  end

end
