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
    @signature_dish = FoodItem.find_by_id(params[:dish_name])
    respond_to do |format|
      format.html { render :layout => 'application' }
    end
  end

  def new
    @food_item = FoodItem.new
    @food_item.build_recipe
    @food_item.recipe.sub_menus.build
    @food_item.build_meal_info
    # @food_item.build_review
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
    @food_item.meal_info.is_signature = @food_item.if_signature
    if @food_item.save
      redirect_to '/cms/food_items', :notice => "Successfully created Food Item."
    else
      render :action => 'new'
    end
  end

  def update
    @food_item = FoodItem.find(params[:id])
    @food_item.meal_info.is_signature = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(params[:food_item][:if_signature])
    if @food_item.update_attributes(params[:food_item])
      flash[:notice] = "Successfully updated Food Item."
      redirect_to '/cms/food_items', :notice => "Successfully created Food Item."
    else
      render :action => 'edit'
    end

  end

  def update_ratings
    food_item_review = Review.find_or_create_by_food_item_id_and_hola_user_id(params[:food_item_id], hola_current_user.id)
    if food_item_review
      food_item_review.update_attributes(ratings: params[:food_item_ratings].to_i, review_date: Date.today)
      respond_to do |format|
        format.js
      end
    end
  end

end
