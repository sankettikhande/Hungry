class HolaSessionController < ApplicationController
  def create
    @hola_user = HolaUser.create_from_params({ phone_no: params[:mobile],
                                              name: params[:name]
                                            })
    generate_and_send_opt
  end

  def confirm_with_otp
    @hola_user = HolaUser.create_from_params({phone_no: Base64.decode64(params[:pnx])})
    respond_to do |format|
      format.html {
        cookies.signed[:user_mobile] = {value: @hola_user.phoneNumber, expires: 5.year.from_now} if @hola_user
        redirect_to params[:redirect_to_url]
      }
      format.js{
        @otp_authenticated = @hola_user.authenticate_otp(params[:otp], drift: 30.minutes)
      }
    end
  end

  def regenerate_otp
    @hola_user = HolaUser.create_from_params({phone_no: Base64.decode64(params[:pnx])})
    generate_and_send_opt
  end

  private
  def generate_and_send_opt
    otp_code = @hola_user.otp_code(time: (Time.now + 30.minutes))
    message = "Hola! Our chef has received your order and is on it already. Your order number is 1 for Rs. 1. See your invoice here #{otp_code} ."
    MessagingLib.send_messages(message, @hola_user.phoneNumber, "Transaction")
  end
end
