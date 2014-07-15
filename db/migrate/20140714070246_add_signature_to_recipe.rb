class AddSignatureToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :if_signature, :boolean, :default => false
    add_column :recipes, :if_recipe, :boolean, :default => false
    add_column :recipes, :cuisine, :string
    add_column :recipes, :category, :string
    add_column :recipes, :treatment, :string
  end
end
