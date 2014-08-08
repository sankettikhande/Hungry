class AddClassificationToCheffs < ActiveRecord::Migration
  def change
    add_column :chef_profiles, :classification, :text
  end
end
