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
          :cheff_name => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture) }
          return menu
        else
          menu = {:price => menu.food_item.meal_info.hola_sell_price, :quantity => 0, :dish_name => menu.food_item.meal_info.name,
                  :cheff_name => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
          return menu
        end
       end
      end
    else
      menu = {:price => menu.food_item.meal_info.hola_sell_price, :quantity => 0, :dish_name => menu.food_item.meal_info.name,
              :cheff_name  => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
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
                    :cheff_name => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
            return menu
          end
        end
      end
      menu = {:price => menu.food_item.meal_info.hola_sell_price, :quantity => 0, :dish_name => menu.food_item.meal_info.name,
                 :cheff_name => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url =>(menu.cheff.picture.image.url if menu.cheff.picture)}
         return menu
    else
      menu = {:price => menu.food_item.meal_info.hola_sell_price, :quantity => 0, :dish_name => menu.food_item.meal_info.name,
              :cheff_name => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
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

  def set_drop_down_title(controller, action)
    case
    when controller == "ordered_menus" && action == "checkout"
      return "Review Order"
    when controller == "cms/dishes" && action == "show_recipe"
      return "Recipe"
    when controller == "cms/dishes" && action == "signature_dishes"
      return "Signature Dish"
    when controller == "cms/orders" && action == "payment_gateway"
      return "Select Payment Method"
    when controller == "cms/orders" && action == "order_confirm"
      return "Thank You!"
    when controller == "cms/cheffs" && action == "show_details"
      return "Meet the Chef"
    else
      return "Today's Menu"
    end
  end

  def set_menu_type(food_item)
    return food_item.recipe.dish_type == "veg" ? "veg" : "non-veg"
  end

  def set_menu_icon(food_item)
    return food_item.recipe.dish_type == "veg" ? "pv-icon" : "nv-icon"
  end


  def set_cooing_today_type(cooking_today)
    return cooking_today.food_item.recipe.dish_type == "veg" ? "veg" : "non-veg"
  end

  def get_user_details
    user = HolaUser.find_by_phoneNumber(cookies[:user_mobile]) if !cookies[:user_mobile].blank?
    return user if user
  end

  def nested_messages(messages)
    messages.map do |message, sub_messages|
      render(message) + content_tag(:div, nested_messages(sub_messages), :class => "nested_messages")
    end.join.html_safe
  end

  def render_parent_select_box(cuisine)
    if !cuisine.parent.blank?
      return select_tag "cuisines[]", (options_for_select(cuisine.parent.siblings.collect{ |u| [u.name, u.id]}, :selected => cuisine.parent)), :prompt => "Select Cuisine", :class => "cuisine"
    else
      return select_tag "cuisines[]", (options_for_select(cuisine.siblings.collect{ |u| [u.name, u.id]}, :selected => cuisine)), :prompt => "Select Cuisine", :class => "cuisine"
    end

  end

  def add_chef_filled_class(chef)
    hola_user = HolaUser.find_by_phoneNumber(cookies[:user_mobile]) if !cookies[:user_mobile].blank?
    fav_chef = MyFavoriteChef.where(:hola_user_id => hola_user.id, :cheff_id => chef.id)  if hola_user
    if !fav_chef.blank?
      return "filled"
    else
      return ""
    end
  end

  def add_recipe_filled_class(recipe)
    hola_user = HolaUser.find_by_phoneNumber(cookies[:user_mobile]) if !cookies[:user_mobile].blank?
    fav_chef = MyFavoriteRecipe.where(:hola_user_id => hola_user.id, :food_item_id => recipe.id) if hola_user
    if !fav_chef.blank?
      return "filled"
    else
      return ""
    end
  end

  def chef_image(fav_chef)
    if fav_chef.cheff && fav_chef.cheff.picture
      return fav_chef.cheff.picture.image.url
    else
      return "/assets/user-pic.jpg"
    end
  end

  def set_fav_recipes()
    fav_recipes = MyFavoriteRecipe.group(:food_item_id).count
    max_fav = fav_recipes.values.max
    fav_chart = {}
    fav_recipes.each do |food_item_id, count|
      fav_percent = (count.to_f/max_fav)*100
      fav_chart[food_item_id] = fav_percent
    end
    return fav_chart
  end

  def set_heart_value(recipe, fav_recipes)
   percent = fav_recipes.fetch(recipe.id) if fav_recipes.has_key?(recipe.id)
   return percent
  end

  def set_fav_chefs()
    fav_chefs = MyFavoriteChef.group(:cheff_id).count
    max_fav = fav_chefs.values.max
    fav_chart = {}
    fav_chefs.each do |chef_id, count|
      fav_percent = (count.to_f/max_fav)*100
      fav_chart[chef_id] = fav_percent
    end
    return fav_chart
  end

  def set_chef_heart_value(chef, fav_chefs)
    percent = fav_chefs.fetch(chef.id) if fav_chefs.has_key?(chef.id)
    return percent
  end
end
