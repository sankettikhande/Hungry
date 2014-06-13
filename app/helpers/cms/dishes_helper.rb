module Cms::DishesHelper

  def new # in the ItemController
    @dishes = Dish.new
    @dishes.ingredients.build if @dishes.ingredients.nil?
  end

end
