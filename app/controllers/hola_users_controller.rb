class HolaUsersController < ApplicationController
  def add_chef_to_favorite
    hola_user = HolaUser.find_by_phoneNumber(cookies[:user_mobile]) if !cookies[:user_mobile].blank?
    @add_to_fav = HolaUser.add_to_favorite(hola_user, params[:chef_id]) if hola_user
    respond_to do |format|
      format.js
    end
  end
end
