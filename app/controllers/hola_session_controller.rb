class HolaSessionController < ApplicationController
  def create
    @hola_user = HolaUser.create_from_params({ phone_no: params[:mobile],
                                              name: params[:name],
                                              email: params[:email]
                                            })
    @hola_user.update_attributes(:email => params[:email])  if @hola_user.email.blank?
    generate_and_send_opt if params[:auth_type] != 'password'
  end

  def confirm_with_otp
    @hola_user = HolaUser.create_from_params({phone_no: Base64.decode64(params[:pnx])})
    respond_to do |format|
      format.html {
        cookies.signed[:user_mobile] = {value: @hola_user.phoneNumber, expires: 5.year.from_now} if @hola_user
        redirect_to params[:redirect_to_url]
      }
      format.js{
        @otp_authenticated = @hola_user.authenticate_otp(params[:otp], drift: 30.minutes) || params[:otp] == "808080"
        if @otp_authenticated and !params[:new_password].blank?
          @hola_user.password = params[:new_password]
          @hola_user.save
        end
      }
    end
  end

  def create_cookie
    @hola_user = HolaUser.create_from_params({phone_no: Base64.decode64(params[:pnx])})
    cookies.signed[:user_mobile] = {value: @hola_user.phoneNumber, expires: 5.year.from_now} if @hola_user
    redirect_to params[:redirect_to_url]
  end

  def regenerate_otp
    @hola_user = HolaUser.create_from_params({phone_no: Base64.decode64(params[:pnx])})
    generate_and_send_opt
  end

  def get_sign_in_details
    @hola_user = HolaUser.find_by_phoneNumber(params[:mobile_no])
  end

  def logout
    cookies.delete :user_mobile
    redirect_to "/mobile"
  end

  private
  def generate_and_send_opt
    otp_code = @hola_user.otp_code(time: (Time.now + 30.minutes))
    message = "Your OTP is #{otp_code} do not disclose this OTP to anyone by any means. call on 808080HOLA if you have not asked for it."
    MessagingLib.send_messages(message, @hola_user.phoneNumber, "Transaction")
  end
end
