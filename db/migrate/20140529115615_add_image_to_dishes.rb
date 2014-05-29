class AddImageToDishes < ActiveRecord::Migration
  def change
    add_attachment :dishes, :dish_image if !column_exists?(:dishes, :dish_image)
  end
end
