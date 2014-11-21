class Api::OrdersController < ApiController
  def index
    @orders = Order.includes(:parent_order, :runner, :hola_user, {:ordered_menus => [:cooking_today, {:food_item => :meal_info}]}).order("orders.id desc")
    @orders = @orders.where(order_type: "Regular")
    @orders = @orders.where("DATE(orders.created_at) >= ? ", params[:from_date]) if !params[:from_date].blank?
    @orders = @orders.where("DATE(orders.created_at) <= ? ", params[:to_date]) if !params[:to_date].blank?
    @orders = @orders.where("DATE(orders.created_at) >= ? ", Date.today) if (params[:from_date].blank? && params[:to_date].blank?)

    slots = {"11AM - 12PM" => 1,
             "12PM - 1PM" => 2,
             "1PM - 2PM" => 3,
             "2PM - 3PM" => 4,
             "3PM - 4PM" => 5,
             "4PM - 5PM" => 6,
             "5PM - 6PM" => 7,
             "6PM - 7PM" => 8,
             "7PM - 8PM" => 9,
             "8PM - 9PM" => 10,
             "9PM - 10PM" => 11,
             "10PM - 11PM" => 12}
    @orders = @orders.sort {|a, b| slots[a.delivery_slot].to_i <=> slots[b.delivery_slot].to_i}

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
    new_order.order_status = "Confirmed"
    new_order.order_status_history = ["Created", "Confirmed"]
    new_order.original_order_id = @order.id
    new_order.ordered_menus = new_order.ordered_menus.select{|om| om.order_status != "Canceled"}
    if new_order.save
      new_order.ordered_menus.each do |om|
        cooking_today = om.cooking_today
        om.update_attribute(:order_status, "Ordered")
        if cooking_today && (cooking_today.ordered.to_i + om.quantity.to_i) <= cooking_today.quantity
          cooking_today.update_attribute(:ordered, (cooking_today.ordered.to_i + om.quantity.to_i))
        end
      end
      @order.update_attributes(reorder_id: new_order.id, order_status: "Reordered")
      @message = {"msg" => "New order placed", "order_id" => new_order.id}
      render "api/success"
    else
      @message = new_order.errors.full_messages
      render "api/failure"
    end
  end

  def add_comment
    @order = Order.find params[:order_id]
    if @order
      if !params[:comment].blank? and @order.update_attributes(comment: params[:comment])
        @message = "Order comment updated"
        render "api/success"
      else
        @message = @order.errors.full_messages
        @message << "Comment can not be blank" if params[:comment].blank?
        render "api/failure"
      end
    else
      @message = {"msg" => "Order not found", "order_id" => params[:order_id]}
    end
  end

end
