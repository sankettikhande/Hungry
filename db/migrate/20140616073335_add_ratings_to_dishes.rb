class AddRatingsToDishes < ActiveRecord::Migration
  def change
    add_column :dishes, :ratings, :integer, :default => 0
  end
end
