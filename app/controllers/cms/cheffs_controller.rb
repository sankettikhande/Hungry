class Cms::CheffsController < Cms::ContentBlockController

  skip_before_filter :login_required, :cms_access_required, :only => [:show_details]

  def load_dishes
    dishes = Dish.find_all_by_cheff_id(params[:cheff_id]) if !params[:cheff_id].blank?
    @list = {}.tap{ |h| dishes.each{ |c| h[c.id] = c.name } }
    respond_to do |format|
      format.js
    end
  end

  def new
    @cheff = Cheff.new
    @cheff.build_chef_coordinate
    @cheff.build_chef_profile
    @cheff.cheff_cuisine_geographies.build
    respond_to do |format|
      format.html
      format.js
    end
  end

  def edit
    @cheff  = Cheff.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def show_details
    @chef = Cheff.includes(:cooking_todays).find(params[:chef_id])
    @total_qty = CookingToday.sum(:ordered, :conditions => {:cheff_id => @chef.id})
    @total_receipes = Dish.count(:all, :conditions => {:cheff_id => @chef.id})
    @cooking_todays = @chef.cooking_todays.where(:date => Time.current.to_date)
    @signature_dishes = Dish.where(:if_signature => true, :cheff_id => @chef.id)
    @recipes = Dish.where(:cheff_id => @chef.id)
    respond_to do |format|
      format.html { render :layout => "application"}
    end
  end

  def create
    params[:cheff].delete("cuisine_geographies_attributes")
    params[:cheff].delete("cheff_cuisine_geographies")
    p params
    @cheff = Cheff.create(params[:cheff])
    if @cheff.save
      Cheff.save_cuisine_style(@cheff, params[:cuisine_style]) if params[:cuisine_style]
      Cheff.save_cuisine_geographies(@cheff, params[:cuisine_geography_childrens]) if params[:cuisine_geography_childrens]
      redirect_to '/cms/cheffs', :notice => "Successfully created Chef."
    else
      render :action => 'new'
    end
  end

  def update
    params[:cheff].delete("cuisine_geographies_attributes")
    params[:cheff].delete("cheff_cuisine_geographies")
    params[:cheff].delete("_destroy")
    p params
    @cheff = Cheff.find(params[:id])
    if @cheff.update_attributes(params[:cheff])
      Cheff.save_cuisine_style(@cheff, params[:cuisine_style]) if params[:cuisine_style]
      Cheff.save_cuisine_geographies(@cheff, params[:cuisine_geography_childrens]) if params[:cuisine_geography_childrens]
      redirect_to '/cms/cheffs', :notice => "Successfully created Chef."
    else
      render :action => 'edit'
    end
  end

end
