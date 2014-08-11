class HolaUserAddressesController < ApplicationController
  def index
    @hola_user = hola_current_user
    if @hola_user.present?
      @addresses = @hola_user.hola_user_addresses.all
      @new_address = @hola_user.hola_user_addresses.build
    else
      @addresses = []
      @new_address = HolaUserAddress.new
    end
  end

  def create
    if params[:hola_user_address][:hola_user_id].blank?
      hola_user = HolaUser.find_by_phoneNumber(params[:hola_user_address][:mobile_no])
      hola_user = HolaUser.create(:name => params[:hola_user_address][:name], :phoneNumber => params[:hola_user_address][:mobile_no]) unless hola_user
      params[:hola_user_address][:hola_user_id] = hola_user.id
      cookies.signed[:user_mobile] = { value: hola_user.phoneNumber, expires: 1.year.from_now }
    else
      hola_user = HolaUser.find(params[:hola_user_address][:hola_user_id])
    end
    params[:hola_user_address][:default] = true if hola_user.hola_user_addresses.count == 0
    hola_user_address = HolaUserAddress.new(params[:hola_user_address])
    hola_user_address.save
    flash[:notice] = "Address created successfully."
    redirect_to hola_user_addresses_path
  end

  def set_default
    hola_user = hola_current_user
    hola_user.hola_user_addresses.each do |adds|
      adds.update_attribute(:default, false)
    end
    adds = HolaUserAddress.find(params[:address_id])
    adds.update_attribute(:default, true)
    if adds.hola_user_id && adds.mobile_no
      hola_user = HolaUser.find(adds.hola_user_id)
      hola_user.update_attribute(:phoneNumber, adds.mobile_no)
      cookies.signed[:user_mobile] = { value: adds.mobile_no, expires: 1.year.from_now }
    end
    flash[:notice] = "Default address changed successfully."
  end

  def update
    adds = HolaUserAddress.find(params[:id])
    adds.update_attributes(params[:hola_user_address])
    flash[:notice] = "Address updated successfully."
    redirect_to hola_user_addresses_path
  end
end
