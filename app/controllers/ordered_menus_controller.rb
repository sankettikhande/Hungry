class OrderedMenusController < ApplicationController
  def checkout
    hola_user = hola_current_user
    if hola_user
      @adds = hola_user.hola_user_addresses.default_address.first
      @adds = hola_user.hola_user_addresses.build(name: hola_user.name, mobile_no: hola_user.phoneNumber) unless @adds
    else
      @adds = HolaUserAddress.new
    end
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def order_payment

  end
end
