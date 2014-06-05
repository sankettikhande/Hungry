class OrderedMenusController < ApplicationController
  def checkout
    @order = Order.create(:date => Time.now, :order_status => "Created")
    session[:cart].each do |item|
      item.each do |item_id, item_attr|
        cooking_today  = CookingToday.find(item_id)
        dish = cooking_today.dish
        if @order
          menu = OrderedMenu.create(:order_id => @order.id,:dish_id => dish.id,
                             :cheff_id => dish.cheff.id, :quantity => item_attr['quantity'],
                             :rate => item_attr['price'])
        cooking_today.update_attributes(:ordered => (cooking_today.quantity.to_i - item_attr['quantity'].to_i))
        end
      end
    end
    @order.update_attributes(:total => (OrderedMenu.calculate_total(@order)), :order_status => "Waiting for Payment")
    respond_to do |format|
      format.html {render :layout => 'application'}
    end
  end
end
