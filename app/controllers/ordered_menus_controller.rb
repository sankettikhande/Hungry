class OrderedMenusController < ApplicationController
  def checkout
    @hola_user = hola_current_user
    categories = []
    session[:cart].each do |cart_item|
      cart_item.each do |key, value|
            @categories = categories << value["category"]
      end
    end
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def order_payment

  end

  def get_address_by_type
    hola_user = hola_current_user
    @adds = hola_user.hola_user_addresses.where(address_type: params[:address_type]).first
  end
end
