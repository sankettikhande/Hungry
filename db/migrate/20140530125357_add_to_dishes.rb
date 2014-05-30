class AddToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :dish_type, :string
    add_column :dish_versions, :dish_type, :string
    add_attachment :dish_versions, :dish_image
  end
end
