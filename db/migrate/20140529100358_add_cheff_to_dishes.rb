class AddCheffToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :cheff_id, :integer
  end
end
