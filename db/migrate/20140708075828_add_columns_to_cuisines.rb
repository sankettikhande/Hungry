class AddColumnsToCuisines < ActiveRecord::Migration
  def change
    add_column :cuisine_geographies, :deleted, :boolean
    add_column :cuisine_geographies, :archived, :boolean
    add_column :cuisine_geographies, :published, :boolean
    add_column :cuisine_geographies, :created_by_id, :integer
    add_column :cuisine_geographies, :updated_by_id, :integer
  end
end
