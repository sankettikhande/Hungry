class AddCheffToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :cheff_id, :integer
    change_column :dishes, :if_signature, :boolean, :default => false
  end
end
