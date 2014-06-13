module Cms::DishesHelper

  def new
    @dishes = Dish.new
    @dishes.ingredients.build if @dishes.ingredients.nil?
  end

end
