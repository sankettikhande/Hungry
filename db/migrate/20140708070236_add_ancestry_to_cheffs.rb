class AddAncestryToCheffs < ActiveRecord::Migration
  def change
    add_column :cheffs, :ancestry, :string
    add_index :cheffs, :ancestry
  end
end
