class HomeController < ApplicationController
  def index
    @todays_menu = CookingToday.where(:date => Date.today)
    @cheff_pp = Cheff.find(:all,:order => 'id')
  end

  def review_order
  end
end
