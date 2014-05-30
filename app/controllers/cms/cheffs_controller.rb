class Cms::CheffsController < Cms::ContentBlockController
  def load_dishes
    p params[:cheff_id]
    dishes = Dish.find_all_by_cheff_id(params[:cheff_id]) if !params[:cheff_id].blank?
    p dishes.blank?
    @list = {}.tap{ |h| dishes.each{ |c| h[c.id] = c.name } }
    p @list
    respond_to do |format|
      format.js
    end
  end

end
