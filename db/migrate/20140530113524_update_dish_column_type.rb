class UpdateDishColumnType < ActiveRecord::Migration
  def up
    change_column :cooking_todays, :quantity, :integer, :default => 0
    change_column :cooking_todays, :ordered, :integer, :default => 0
    change_column :cooking_today_versions, :quantity, :integer, :default => 0
    change_column :cooking_today_versions, :ordered, :integer, :default => 0
  end

  def down
  end
end
