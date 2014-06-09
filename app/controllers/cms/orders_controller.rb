class Cms::OrdersController < Cms::ContentBlockController
  skip_before_filter :login_required,:cms_access_required, :only => [:set_cart, :payment_gateway]
  def set_cart
    session[:cart] = [] if session[:cart].nil?
    cart_ids = []
    session[:cart].each do |item|
      item.each do |item_id, item_attr|
        cart_ids << item_id.to_i
      end
    end
    cart_ids = cart_ids.flatten
    if cart_ids.include?(params[:item_id].to_i)
       session[:cart].each do |item|
         session[:cart].delete(item) if item.keys.include?(params[:item_id])
       end
       session[:cart] << ({params[:item_id]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date], 'dish_name' => params[:dish_name] }})
    else
      session[:cart] << ({params[:item_id]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date], 'dish_name' => params[:dish_name] }})
    end
    respond_to do |format|
      format.js
    end
  end

  def payment_gateway
    session[:cart] = []
     respond_to do |format|
       format.html{ render :layout => 'application'}
     end

  end
end
