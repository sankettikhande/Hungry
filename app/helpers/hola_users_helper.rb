module HolaUsersHelper

  def dish_type_css(food_item)
    return food_item.recipe.dish_type == "non-veg" ? "non-veg" : "veg"
  end
end
