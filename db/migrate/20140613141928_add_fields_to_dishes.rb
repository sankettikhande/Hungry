class AddFieldsToDishes < ActiveRecord::Migration
  def change
    add_content_column :dishes, :cooking_time, :integer
    add_content_column :dishes, :serves, :integer
    add_content_column :dishes, :cuisine, :string
    add_content_column :dishes, :tags, :string
    add_content_column :dishes, :category, :string
    add_content_column :dishes, :cooking_equipment, :string
    add_content_column :dishes, :treatment, :string

  end
end
