class Cms::CookingTodaysController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:get_menu_details, :get_item_details]

  def get_menu_details
  @cooking_today = CookingToday.find(params[:cooking_today_id])
  @quantity = params[:cooking_today_qty]
  respond_to do |format|
    format.js{render layout: 'application'}
  end

  end

  def get_item_details
    @cooking_today = CookingToday.find(params[:cooking_today_id])
    respond_to do |format|
      format.js{render layout: 'application'}
    end
  end

end
