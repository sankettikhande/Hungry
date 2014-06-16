class Cms::DishesController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:show_recipe, :signature_dishes]
  def show_recipe
    @title = "Recipe"
    @footer = "false"
    @recipe = Dish.find_by_name(params[:recipe_name])
     respond_to do |format|
       format.html { render :layout=>'application' }
     end
  end

  def signature_dishes
    @signature_dish = Dish.find_by_name(params[:dish_name])
    respond_to do |format|
      format.html { render :layout => 'application' }
    end
  end
  def new
    @dish = Dish.new
    1.times { @dish.ingredients.build }
    1.times { @dish.prepration_steps.build }
    1.times { @dish.tips.build }
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
