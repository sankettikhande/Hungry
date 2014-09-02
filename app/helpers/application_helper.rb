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

  def back_actions(params)
    if params[:controller] == "cms/orders" && params[:action] == "order_confirm" || params[:controller] == "ordered_menus" && params[:action] == "checkout"
      "/mobile"
    elsif params[:TxStatus] == "CANCELED"
      "/review_order"
    else
      :back
    end
  end

  def collect_cart_items(menu)
    today = {}
    if !session[:cart].blank?
      session[:cart].each do |item|
       item.each do |item_id, item_attr|
        if menu.id == item_id.to_i
          menu = {:price => item_attr['price'], :quantity => item_attr['quantity'], :dish_name => item_attr['dish_name'], :category => item_attr['category'],
          :cheff_name => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture) }
          return menu
        else
          menu = {:price => menu.food_item.meal_info.hola_sell_price, :quantity => 0, :dish_name => menu.food_item.meal_info.name, :category => menu.food_item.recipe.category,
                  :cheff_name => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
          return menu
        end
       end
      end
    else
      menu = {:price => menu.food_item.meal_info.hola_sell_price, :quantity => 0, :dish_name => menu.food_item.meal_info.name, :category => menu.food_item.recipe.category,
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
            menu = {:price => item_attr['price'], :quantity => item_attr['quantity'], :dish_name => item_attr['dish_name'], :category => item_attr['category'],
                    :cheff_name => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url => (menu.cheff.picture.image.url if menu.cheff.picture)}
            return menu
          end
        end
      end
      menu = {:price => menu.food_item.meal_info.hola_sell_price, :quantity => 1, :dish_name => menu.food_item.meal_info.name, :category => menu.food_item.recipe.category,
                 :cheff_name => menu.cheff.chef_coordinate.name, :cheff_id => menu.cheff.id, :cheff_image_url =>(menu.cheff.picture.image.url if menu.cheff.picture)}
         return menu
    else
      menu = {:price => menu.food_item.meal_info.hola_sell_price, :quantity => 1, :dish_name => menu.food_item.meal_info.name, :category => menu.food_item.recipe.category,
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

  def set_drop_down_title(controller, action, id)
    if controller == "cms/food_items" && action == "show_recipe"
      item = FoodItem.find id
    end
    case
    when controller == "ordered_menus" && action == "checkout"
      return "Review Order"
    when controller == "cms/food_items" && action == "show_recipe" && item.if_signature
      return "Recipe"
    when controller == "cms/food_items" && action == "show_recipe" && !item.if_signature
      return "About the dish"
    when controller == "cms/food_items" && action == "signature_dishes"
      return "Signature Dish"
    when controller == "cms/orders" && action == "payment_gateway"
      return "Select Payment Method"
    when controller == "cms/orders" && action == "order_confirm"
      return "Thank You!"
    when controller == "cms/cheffs" && action == "show_details"
      return "Meet the Chef"
    when controller == "hola_users" && action == "signature_dishes" || action == "favourite_signature_dishes"
      return "Signature Dishes"
    when controller == "hola_users" && action == "recipes" || action == "favourite_recipes"
      return "Recipes"
    when controller == "hola_users" && action == "my_favorite_chefs"
      return "Favourites"
    when controller == "order_histories"
      return "Order History"
    when controller == "hola_user_addresses"
      return "Address"
    when controller == "cms/feedbacks" && action == "talk_to_us"
      return "Talk To Us"
    when controller == "social_shares" && action == "index" || action == "tell_friends"
      return "Love Us"
    when controller == "party_orders"
      return "Party Orders"
    when controller == "home" && action == "add_other_dishes"
      return "Add #{params[:category]}"
    when controller == "cms/chef_requests" && action == "become_chef"
      return "Become a Chef"
    else

      meal_availability_hash = CookingToday.meal_type_time_span
      meal_availability_hash.each do |category, meal_availability|
        meal_availability_from_time = Time.zone.parse("#{Date.today} #{meal_availability[:from]}")
        meal_availability_to_time = Time.zone.parse("#{Date.today} #{meal_availability[:to]}")
        return category if (Time.now > meal_availability_from_time and Time.now < meal_availability_to_time)
      end
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
    user = hola_current_user
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
    hola_user = hola_current_user
    fav_chef = MyFavoriteChef.where(:hola_user_id => hola_user.id, :cheff_id => chef.id)  if hola_user
    if !fav_chef.blank?
      return "filled"
    else
      return ""
    end
  end

  def add_recipe_filled_class(recipe)
    hola_user = hola_current_user
    fav_chef = MyFavoriteRecipe.where(:hola_user_id => hola_user.id, :food_item_id => recipe.id) if hola_user
    if !fav_chef.blank?
      return "filled"
    else
      return ""
    end
  end

  def set_class_active_favourite(action)
    return "active" if action.split("_").first == "favourite"
  end

  def chef_image(fav_chef)
    if fav_chef.cheff && fav_chef.cheff.picture
      return fav_chef.cheff.picture.image.url
    else
      return "/assets/chef-icon.jpg"
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

  def alert_message message, options = {}
    alert_class = options[:alert_class] || "alert alert-info text-center"
    content_tag(:div, message, class: alert_class)
  end

  def set_class_to_list(params)
    if params[:popular].present? || params[:action].split("_").first == "favourite"
      return ""
    else
      "active"
    end
  end

  def dish_type_css(food_item)
    if food_item.meal_info && food_item.meal_info.picture
      ""
    else
      food_item.recipe.dish_type == "non-veg" ? "non-veg" : "veg"
    end
  end

  def login_check
    login_required_urls_suffix = ["order_histories", "my_favorite_chefs", "favourites", "add-address"]
    current_url_suffix = request.url.split("?").first.split("/").last
    if !hola_current_user and login_required_urls_suffix.include? current_url_suffix
      content_tag(:script, "$('#login_modal').modal('show')".html_safe)
    end
  end

  def get_remaining_category(categories)
    all_categories = ["Main Course","Side Dish","Dessert"]
    ordered_categories = categories
    return remaining_categories = all_categories - ordered_categories
  end

  def meal_available? meal_type
    meal_availability = CookingToday.meal_type_time_span[meal_type]
    meal_availability_from_time = Time.zone.parse("#{Date.today} #{meal_availability[:from]}")
    meal_availability_to_time = Time.zone.parse("#{Date.today} #{meal_availability[:to]}")
    (Time.now < meal_availability_to_time)
  end

end

