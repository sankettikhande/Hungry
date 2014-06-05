class Cms::OrdersController < Cms::ContentBlockController
  skip_before_filter :login_required,:cms_access_required, :only => [:set_cart]
  def set_cart
    session[:cart] << ({params[:item]=>{'quantity'=> params[:qty], 'price' => params[:price], 'date' => params[:date] }})
    respond_to do |format|
      format.js
    end
  end
end
