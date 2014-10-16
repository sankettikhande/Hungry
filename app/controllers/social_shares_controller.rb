class SocialSharesController < ApplicationController
  def index

  end

  def tell_friends
  end

  def send_referal_email
    email_details = {:recepients => params[:to_email], :subject => params[:subject], :email_body => params[:body]}
    flash.now[:notice] = "Email sent successfully!!!" if Notifier.send_referal_emails(email_details).deliver
    respond_to do |format|
      format.html{ render :template => "social_shares/tell_friends"}
    end
  end
end
