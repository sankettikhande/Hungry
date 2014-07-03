class ChangeQuantityInIngredients < ActiveRecord::Migration
  def change
    change_column :ingredients, :quantity, :string
  end
end
