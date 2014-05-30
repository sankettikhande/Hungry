class UpdateDishes < ActiveRecord::Migration
  def up
    remove_column :dishes, :price if column_exists? :dishes, :price
    remove_column :dish_versions, :price if column_exists? :dish_versions, :price
    add_column :dishes, :price, :integer
    add_column :dish_versions, :price, :integer
  end

  def down
  end
end
