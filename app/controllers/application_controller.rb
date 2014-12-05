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

  def calculate_order_amounts
    if session[:coupon_code]
      coupon = Coupon.find_by_coupon_code(session[:coupon_code])
      @discount = coupon.discount(@total).to_i if coupon
      @paid_amount = @total -  @discount
      session[:discountAmount] = @discount
      session[:paidAmount] = @total
      session[:netAmount] = @paid_amount

      # Added for removal of added coupon on navigation issue pre-order orders issue
      # session[:coupon_code] = params[:coupon_code]
    end
  end


  def clear_session
    session.delete(:cart)
    session.delete(:lt)
    session.delete(:dt)
    session.delete(:coupon_code)
    session.delete(:discountAmount)
    session.delete(:paidAmount)
    session.delete(:netAmount)
  end

  def insufficient_inventory? 
    @insufficient_inventory_items_info = {}
    menu_quantity_map = get_inventory_for_cart_items
    session[:cart].each do |item|
      cooking_today_id = item.keys.first.split("_").first 
      cooking_today_inventory_info = menu_quantity_map[cooking_today_id.to_i]
      if cooking_today_inventory_info
        item_info = item.values.first
        total_ordered = cooking_today_inventory_info['sold_quantity'] + item_info['quantity'].to_i  
        @insufficient_inventory_items_info.merge!(cooking_today_id: item_info['dish_id'], item_name: item_info['dish_name'], available_quantity:  cooking_today_inventory_info['available_quantity']) if (total_ordered >= cooking_today_inventory_info['available_quantity'])
      end
    end
    !@insufficient_inventory_items_info.blank?
  end

  def get_inventory_for_cart_items
    menu_quantity_map = {}
    cooking_today_ids = session[:cart].collect{|item| item.keys}.flatten.collect {|c| c.split("_").first}
    ordered_menus = OrderedMenu.where(cooking_today_id: cooking_today_ids).joins(:order, :cooking_today).where("orders.order_status != 'Created'").select("sum(ordered_menus.quantity) as sold_quantity, ordered_menus.cooking_today_id, cooking_todays.quantity as available_quantity").group("ordered_menus.cooking_today_id")
    ordered_menus.collect {|om| menu_quantity_map.merge!(om.cooking_today_id => {"sold_quantity" => om.sold_quantity, "available_quantity" => om.available_quantity})}
    menu_quantity_map
  end

  def check_inventory
    redirect_to "/", alert: "Sorry! There were some menus in your cart that we can't serve right now." if insufficient_inventory?
  end

  def set_cache_buster
    response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
    response.headers["Pragma"] = "no-cache"
    response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
  end

end
