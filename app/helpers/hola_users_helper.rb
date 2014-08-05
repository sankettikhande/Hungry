module HolaUsersHelper

  def dish_type_css(food_item)
    if food_item.meal_info && food_item.meal_info.picture
      ""
    else
      food_item.recipe.dish_type == "non-veg" ? "non-veg" : "veg"
    end
  end
end
