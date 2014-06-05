class Cms::OrderedMenusController < Cms::ContentBlockController
  skip_before_filter :login_required,:cms_access_required, :current_user, :only => [:checkout]

  def checkout
    @order = Order.create(:date => Time.now)
    session[:cart].each do |item|
     item.each do |k,v|
       cooking_today  = CookingToday.find(k)
       dish = cooking_today.dish
       if @order
          OrderedMenu.create(:order_id => @order.id,:dish_id => dish.id,
                                        :cheff_id => dish.cheff.id, :quantity => v['quantity'],
                                        :rate => v['price'])
       end
     end
    end
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end
end
