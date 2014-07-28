class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

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
      redirect_to "mobile/?redirected=true" unless session[:on_mobile]
    end
  end

end