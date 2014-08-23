class Cms::ChefRequestsController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:create_chef, :become_chef]

  def become_chef
    @become_chef = ChefRequest.new
    respond_to do |format|
      format.html {render :layout => 'application'}
    end

  end

  def create_chef
    @become_chef = ChefRequest.new(params[:chef_request])
    if @become_chef.save
      redirect_to "/become-a-chef", notice: "Request sent Succesfully!!!"
    else
      render 'become_chef'
    end

  end
end
