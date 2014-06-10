class Cms::CookingTodaysController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:get_review_order_details, :get_item_details, :total_calculation, :delete_item]

  def get_review_order_details
    @cooking_today = CookingToday.find(params[:cooking_today_id])
    @quantity = params[:cooking_today_qty]
    respond_to do |format|
      format.js {render layout: 'application'}
    end
  end

  def get_item_details
    @cooking_today = CookingToday.find(params[:cooking_today_id])
    respond_to do |format|
      format.js{render layout: 'application'}
    end
  end

  def total_calculation
   @total = 0
    if !session[:cart].nil?
      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          @total = @total + (item_attr['quantity'].to_i * item_attr['price'].to_i)
        end
      end
    end
    respond_to do |format|
      format.js {render :layout => 'application'}
    end
  end

  def delete_item
    @item_id  = params[:item_id]
    if session[:cart]
      session[:cart].each do |item|
        session[:cart].delete(item) if item.keys.flatten.include?(params[:item_id])
      end
    end
  end

end
