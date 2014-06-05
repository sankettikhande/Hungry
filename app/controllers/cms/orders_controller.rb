class Cms::OrdersController < Cms::ContentBlockController
  skip_before_filter :login_required,:cms_access_required, :only => [:set_cart]
  def set_cart
    p params
    session[:cart] << ({params[:item]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date] }})
    p "---------"
    p session[:cart]
    respond_to do |format|
      format.js
    end
  end
end
