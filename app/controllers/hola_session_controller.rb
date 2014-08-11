class HolaSessionController < ApplicationController
  def create
    hola_user = HolaUser.create_from_params({ phone_no: params[:mobile],
                                              name: params[:name],
                                              save_details_flag: params[:save_user_details]
                                            })
    cookies.signed[:user_mobile] = {value: hola_user.phoneNumber, expires: 5.year.from_now} if hola_user
    respond_to do |format|
      format.js
    end
  end
end
