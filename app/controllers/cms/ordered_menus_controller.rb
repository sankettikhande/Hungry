class Cms::OrderedMenusController < Cms::ContentBlockController
  skip_before_filter :login_required,:cms_access_required, :current_user, :only => [:checkout]

  def checkout
    @order = Order.create(:date => Time.now)
    session[:cart].each do |item|
     item.each do |item_id, item_attr|
       cooking_today  = CookingToday.find(item_id)
       dish = cooking_today.dish
       if @order
          OrderedMenu.create(:order_id => @order.id,:dish_id => dish.id,
                                        :cheff_id => dish.cheff.id, :quantity => item_attr['quantity'],
                                        :rate => item_attr['price'])
       end
     end
    end
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end
end
