class Cms::FeedbacksController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:talk_to_us, :feedback]

  def talk_to_us
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end

  def feedback
    @feedback = Feedback.new(feedback: params[:feedback], email: params[:email], contact_no: params[:contact_no], name: params[:name], is_chef: params[:is_chef])
    if @feedback.save
      if params[:called_from]
        redirect_to :back
      else
        redirect_to "/talk_to_us", notice: "Thanks!! Feedback received."
      end  
    else
      render 'talk_to_us'
    end
  end

end
