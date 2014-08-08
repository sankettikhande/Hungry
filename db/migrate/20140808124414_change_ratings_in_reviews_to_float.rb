class ChangeRatingsInReviewsToFloat < ActiveRecord::Migration
  def up
    change_column :reviews, :ratings, :decimal, precision: 2, scale: 1
  end

  def down
    change_column :reviews, :ratings, :integer
  end
end
