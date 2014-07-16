class Cms::FoodItemsController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:show_recipe, :signature_dishes, :update_ratings]

  def show_recipe
    @footer = "false"
    @food_item = FoodItem.find(params[:id]) if !params[:id].blank?
    respond_to do |format|
      format.html { render :layout=>'application' }
    end
  end

  def signature_dishes
    @signature_dish = Dish.find_by_id(params[:dish_name])
    respond_to do |format|
      format.html { render :layout => 'application' }
    end
  end

  def new
    @food_item = FoodItem.new
    @food_item.build_recipe
    @food_item.recipe.sub_menus.build
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

  def update_ratings
    food_item = FoodItem.find(params[:food_item_id])
    if food_item
      food_item.review.update_attributes(:ratings => (food_item.review.ratings.to_i + params[:food_item_ratings].to_i))
      respond_to do |format|
        format.js
      end
    end
  end

end
