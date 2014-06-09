class Cms::OrdersController < Cms::ContentBlockController
  skip_before_filter :login_required,:cms_access_required, :only => [:set_cart, :payment_gateway]
  def set_cart
    session[:cart] = [] if session[:cart].nil?
    session[:cart] << ({params[:item_id]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date], 'dish_name' => params[:dish_name] }})

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
