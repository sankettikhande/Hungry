class HolaSessionController < ApplicationController
  def create
    hola_user = HolaUser.create_from_params({ phone_no: params[:mobile],
                                              name: params[:name]
                                            })
    session[:hola_user_id] = hola_user.id

    respond_to do |format|
      format.js
    end
  end
end
