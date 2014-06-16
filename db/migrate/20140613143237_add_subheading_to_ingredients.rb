class AddSubheadingToIngredients < ActiveRecord::Migration
  def change
    add_column :ingredients, :unit, :string
    add_column :ingredients, :sub_heading, :string
  end
end
