class Cms::FoodItemsController < Cms::ContentBlockController
  def new
    @food_item = FoodItem.new
    @food_item.build_recipe
    @food_item.recipe.ingredients.build
    @food_item.recipe.prepration_steps.build
    @food_item.build_meal_info

    @food_item.build_review
    respond_to do |format|
      format.html
    end
  end

  def edit
    @food_item = FoodItem.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def create
    @food_item = FoodItem.new(params[:food_item])
    if @food_item.save
      redirect_to '/cms/food_items', :notice => "Successfully created Food Item."
    else
      render :action => 'new'
    end
  end

  def update
    @food_item = FoodItem.find(params[:id])
    if @food_item.update_attributes(params[:food_item])
      flash[:notice] = "Successfully updated Food Item."
      redirect_to '/cms/food_items', :notice => "Successfully created Food Item."
    else
      render :action => 'edit'
    end

  end

end
