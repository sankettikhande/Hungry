module Cms::CheffsHelper
  def collect_cuisines_geographies
    return CuisineGeography.where(:ancestry => nil)
  end

  def get_cuisine_geography(cuisine)
    cuisines = []
    if  cuisine.parent.blank?
      cuisines << cuisine.parent.name
    else
      get_cuisine_geography(cuisine)
    end

    return cuisines
  end
end
