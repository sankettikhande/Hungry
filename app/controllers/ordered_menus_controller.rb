class OrderedMenusController < ApplicationController
  def checkout
   @title = "Review Order"
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def order_payment

  end
end
