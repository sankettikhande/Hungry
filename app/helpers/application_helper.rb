module ApplicationHelper
  def qty_left(menu)
    qty = menu.quantity - menu.ordered if menu.quantity
    return  qty
  end

  def collect_items(cart)
    today = {}
    cart.each do |item|
      item.each do |item_id, item_attr|
        today[item_id.to_i] = item_attr['quantity'].to_i
      end
    end
    return today
  end

  def collect_cart_items(menu)
    today = {}
    if !session[:cart].blank?
      session[:cart].each do |item|
       item.each do |item_id, item_attr|
        if menu.id == item_id.to_i
          menu = {:price => item_attr['price'], :quantity => item_attr['quantity'], :dish_name => item_attr['dish_name'],
          :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => menu.cheff.cheff_image.url}
          return menu
        else
          menu = {:price => menu.dish.price, :quantity => 0, :dish_name => menu.dish.name,
                  :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => menu.cheff.cheff_image.url}
          return menu
        end
       end
      end
    else
      menu = {:price => menu.dish.price, :quantity => 0, :dish_name => menu.dish.name,
              :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => menu.cheff.cheff_image.url}
      return menu
    end

  end

  def collect_cart(menu)
    today = {}
    if session[:cart]
      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          if menu.id == item_id.to_i
            menu = {:price => item_attr['price'], :quantity => item_attr['quantity'], :dish_name => item_attr['dish_name'],
                    :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => menu.cheff.cheff_image.url}
            return menu
          end
        end
      end
      menu = {:price => menu.dish.price, :quantity => 0, :dish_name => menu.dish.name,
                 :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => menu.cheff.cheff_image.url}
         return menu
    else
      menu = {:price => menu.dish.price, :quantity => 0, :dish_name => menu.dish.name,
              :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => menu.cheff.cheff_image.url}
      return menu
    end

  end

  def calculate_total_price
    total = 0
    if session[:cart]
      session[:cart].each do |item|
        item.each do |item_id, item_attr|
          total = total + (item_attr['quantity'].to_i * item_attr['price'].to_i)
        end
      end
    end
    return total
  end

end
