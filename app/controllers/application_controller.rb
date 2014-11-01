class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  helper_method :hola_current_user
  helper_method :mobile_device?
  helper_method :is_mobile?

  private

  def hola_current_user
    @hola_current_user || HolaUser.find_by_phoneNumber(cookies.signed[:user_mobile])
  end

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end

  def is_mobile?
    request.user_agent =~ /Mobile|webOS/
  end




  def prepare_for_mobile

    if !mobile_device? and !params[:source]
      session[:on_mobile] = nil
      return if session[:on_desktop] and session[:on_desktop] == true
      unless params[:redirected]
        session[:on_desktop] = true
        redirect_to "/desktop?redirected=true"
      end
    else
      session[:on_desktop] = nil
      session[:on_mobile] = true
      return if session[:on_mobile] and session[:on_mobile] == true
        session[:on_mobile] = true
        redirect_to "/mobile"
    end
  end

end
