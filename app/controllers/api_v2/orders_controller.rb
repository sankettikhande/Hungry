class ApiV2::OrdersController < ApiController
  def index
    @orders = Order.order_items_list(params[:from_date], params[:to_date])
  end

  def update_area_and_sub_area
    @order = Order.find_by_id(params[:order_id])
    if !@order.blank? && !@order.delivery_address_id.blank?
      @order.delivery_address.update_attributes(:area =>params[:area], :sub_area => params[:sub_area] )
        render "api/success"
    else
        @message = "There is no address associated with this order."
        render "api/failure"
    end
  end
end
