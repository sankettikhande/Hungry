class HomeController < ApplicationController
  def index
    @todays_menu = CookingToday.where(:date => Date.today)
  end
end
