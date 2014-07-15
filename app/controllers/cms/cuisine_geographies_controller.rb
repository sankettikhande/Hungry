class Cms::CuisineGeographiesController < Cms::ContentBlockController
  skip_before_filter :login_required, :cms_access_required, :only => [:load_sub_cuisines]
  def index
    @cuisine_geographies = CuisineGeography.scoped
    @cuisine_geography = CuisineGeography.new

    respond_to do |format|
      format.html
    end
  end

  def new
    @cuisine_geography= CuisineGeography.new(:parent_id => params[:parent_id])
    respond_to do |format|
      format.html
    end
  end

  def load_sub_cuisines
    @cuisine_geography = CuisineGeography.find(params[:parent_id])
    @parent_field = params[:parent_field]
    @parent = @cuisine_geography.parent
    if @cuisine_geography && !@cuisine_geography.children.blank?
      @cuisine_childrens = @cuisine_geography.children
      @list = {}.tap{ |h| @cuisine_childrens.each{ |c| h[c.id] = c.name } }
    end
    respond_to do |format|
      format.js
    end
  end
end
