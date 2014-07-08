class Cms::DishesController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:show_recipe, :signature_dishes, :update_ratings]
  def show_recipe
    @footer = "false"
    @recipe = Dish.find_by_id(params[:recipe_name]) if !params[:recipe_name].blank?
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
    1.times { @dish.sub_menus.build }
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

  def update_ratings
    dish = Dish.find(params[:dish_id])
    if dish
      dish.update_attributes(:ratings => (dish.ratings.to_i + params[:dish_ratings].to_i))
      respond_to do |format|
        format.js
      end
    end
  end

  def create
    @dish = Dish.new(params[:dish])
    if @dish.save
      redirect_to '/cms/dishes', :notice => "Successfully created dish."
    else
      render :action => 'new'
    end
  end

  def update
    @dish = Dish.find(params[:id])
    if @dish.update_attributes(params[:dish])
      flash[:notice] = "Successfully updated product."
      redirect_to '/cms/dishes', :notice => "Successfully created dish."
    else
      render :action => 'edit'
    end

  end

end
