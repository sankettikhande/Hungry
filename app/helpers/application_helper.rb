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
          :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture) }
          return menu
        else
          menu = {:price => menu.dish.price, :quantity => 0, :dish_name => menu.dish.name,
                  :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
          return menu
        end
       end
      end
    else
      menu = {:price => menu.dish.price, :quantity => 0, :dish_name => menu.dish.name,
              :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
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
                    :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
            return menu
          end
        end
      end
      menu = {:price => menu.dish.price, :quantity => 0, :dish_name => menu.dish.name,
                 :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url =>(menu.cheff.picture.image.url if menu.cheff.picture)}
         return menu
    else
      menu = {:price => menu.dish.price, :quantity => 0, :dish_name => menu.dish.name,
              :cheff_name => menu.cheff.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
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

  def link_to_remove_fields(name, f)
    f.hidden_field(:_destroy) + link_to_function(name, "remove_fields(this)")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function(name, "add_fields(this, \'#{association}\', \'#{escape_javascript(fields)}\')")
  end
end
