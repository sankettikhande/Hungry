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
    @chef = Cheff.new
    respond_to do |format|
      format.html
    end
  end

  def edit
    @chef  = Cheff.find(params[:id])
    respond_to do |format|
      format.html
    end
  end

  def show_details
    @title = "Meet the Chef"
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

end
