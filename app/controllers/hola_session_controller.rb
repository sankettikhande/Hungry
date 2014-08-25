class HolaSessionController < ApplicationController
  def create
    hola_user = HolaUser.create_from_params({ phone_no: params[:mobile],
                                              name: params[:name]
                                            })
    cookies.signed[:user_mobile] = {value: hola_user.phoneNumber, expires: 5.year.from_now} if hola_user
    respond_to do |format|
      format.html{
        redirect_to params[:redirect_to_url]
      }
    end
  end
end
