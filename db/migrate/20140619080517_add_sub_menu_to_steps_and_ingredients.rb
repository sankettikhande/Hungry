class AddSubMenuToStepsAndIngredients < ActiveRecord::Migration
  def change
    add_column :prepration_steps, :sub_menu_id, :integer
    add_column :ingredients, :sub_menu_id, :integer
  end
end
