class Cms::DishesController < Cms::ContentBlockController
  def new
    @dish = Dish.new
    1.times { @dish.ingredients.build }
    respond_to do |format|
      format.html
    end
  end

  def edit
    @dish  = Dish.find(params[:id])
    respond_to do |format|
      format.html
    end
  end
end
