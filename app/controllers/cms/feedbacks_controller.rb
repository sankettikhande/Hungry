class Cms::FeedbacksController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:talk_to_us, :feedback]

  def talk_to_us
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def feedback
    @feedback = Feedback.new(feedback: params[:feedback], email: params[:email], contact_no: params[:contact_no], name: params[:name])
    if @feedback.save
      redirect_to "/talk_to_us", notice: "Thanks!! Feedback received."
    else
      render 'talk_to_us'
    end
  end

end
