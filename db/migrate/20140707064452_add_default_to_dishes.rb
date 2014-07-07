class AddDefaultToDishes < ActiveRecord::Migration
  def change
    change_column :dishes, :days_notice, :integer, :default => 0
    change_column :dishes, :portions, :integer, :default => 1
  end
end
