class AddColumnsToSubMenus < ActiveRecord::Migration
  def change
    add_column :sub_menus, :deleted, :boolean
    add_column :sub_menus, :archived, :boolean
    add_column :sub_menus, :published, :boolean
    add_column :sub_menus, :created_by_id, :integer
    add_column :sub_menus, :updated_by_id, :integer
    add_column :sub_menus, :name, :string
  end
end
