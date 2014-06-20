class Cms::SubMenusController < Cms::ContentBlockController
  def new
  end

  def edit
    @sub_menu = SubMenu.find(params[:id])
    1.times {@sub_menu.ingredients.build}
    1.times {@sub_menu.prepration_steps.build}
    respond_to do |format|
      format.html
    end
  end

end