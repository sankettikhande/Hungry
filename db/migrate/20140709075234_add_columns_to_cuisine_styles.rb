class AddColumnsToCuisineStyles < ActiveRecord::Migration
  def change
    add_column :cuisine_styles, :deleted, :boolean
    add_column :cuisine_styles, :archived, :boolean
    add_column :cuisine_styles, :published, :boolean
    add_column :cuisine_styles, :created_by_id, :integer
    add_column :cuisine_styles, :updated_by_id, :integer
  end
end
