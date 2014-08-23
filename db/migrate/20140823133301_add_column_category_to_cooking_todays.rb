class AddColumnCategoryToCookingTodays < ActiveRecord::Migration
  def change
    add_column :cooking_todays, :category, :string
  end
end
