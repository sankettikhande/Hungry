class RemoveTreatmentFromIngredients < ActiveRecord::Migration
  def up
    remove_column :ingredients, :treatment
    remove_column :ingredients, :cooking_equipment
  end

  def down
  end
end
