class OrderedMenusController < ApplicationController
  def checkout
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def order_payment

  end
end
