class TemporaryHomeController < ApplicationController

  def index
    respond_to do |format|
      format.html {render :layout => false}
    end
  end

  def send_mail
    @temp_home = TemporaryHome.create(:email => params[:email])
    redirect_to "/"
  end
end
