class HolaUserAddressesController < ApplicationController
  def index
    @hola_user = current_user
    if @hola_user.present?
      @addresses = @hola_user.hola_user_addresses.all
      @new_address = @hola_user.hola_user_addresses.build
    end
  end

  def create
    hola_user_address = HolaUserAddress.new(params[:hola_user_address])
    hola_user_address.save
    redirect_to hola_user_addresses_path
  end

  def set_default
    hola_user = current_user
    hola_user.hola_user_addresses.each do |adds|
      adds.update_attribute(:default, false)
    end
    adds = HolaUserAddress.find(params[:address_id])
    adds.update_attribute(:default, true)
    render nothing: true
  end

  def update
    adds = HolaUserAddress.find(params[:id])
    adds.update_attributes(params[:hola_user_address])
    redirect_to hola_user_addresses_path
  end
end
