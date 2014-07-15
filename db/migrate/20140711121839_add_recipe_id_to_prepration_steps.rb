class AddRecipeIdToPreprationSteps < ActiveRecord::Migration
  def change
    add_column :prepration_steps, :recipe_id, :integer
  end
end
