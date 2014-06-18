class Cms::OrdersController < Cms::ContentBlockController
  skip_before_filter :login_required,:cms_access_required, :only => [:set_cart, :payment_gateway,:order_confirm, :remove_from_cart]
  def set_cart
    session[:cart] = [] if session[:cart].nil?
    cart_ids = []
    cart_ids = session[:cart].collect{|item| item.keys}.flatten
    if cart_ids.include?(params[:item_id])
       session[:cart].each do |item|
         session[:cart].delete(item) if item.keys.flatten.include?(params[:item_id])
       end
       session[:cart] << ({params[:item_id]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date], 'dish_name' => params[:dish_name] }})
    else
      session[:cart] << ({params[:item_id]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date], 'dish_name' => params[:dish_name] }})
    end
    @total = 0
    if !session[:cart].nil?
      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          @total = @total + (item_attr['quantity'].to_i * item_attr['price'].to_i)
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def remove_from_cart
    session[:cart].each do |item|
      key = item.keys.collect{|c| c.to_i}.join('').to_i
      if key == params[:item_id].to_i
        session[:cart].delete(item)
      end
    end
    @total = 0
    if !session[:cart].nil?
      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          @total = @total + (item_attr['quantity'].to_i * item_attr['price'].to_i)
        end
      end
    end
    respond_to do |format|
      format.js
    end
  end

  def payment_gateway
    @title = "Select Payment Method"
    @order = Order.create(:date => Time.now, :order_status => "Created")
    session[:cart].each do |item|
      item.each do |item_id, item_attr|
        cooking_today  = CookingToday.find(item_id)
        dish = cooking_today.dish
        if @order
          menu = OrderedMenu.create(:order_id => @order.id,:dish_id => dish.id,
                                    :cheff_id => dish.cheff.id, :quantity => item_attr['quantity'],
                                    :rate => item_attr['price'])
          cooking_today.update_attributes(:quantity => (cooking_today.quantity.to_i - item_attr['quantity'].to_i),
                                          :ordered => (cooking_today.ordered.to_i + item_attr['quantity'].to_i)
          )
        end
      end
    end
    @order.update_attributes(:total => (OrderedMenu.calculate_total(@order)), :order_status => "Waiting for Payment",
                             :name=>params[:orders][:name], :address=>params[:orders][:address],
                             :phone_no=>params[:orders][:phone_no])
    #session[:cart] = []
    @footer = "false"
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def order_confirm
    @title = "Thank You!"
    @footer = "false"
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end
end
