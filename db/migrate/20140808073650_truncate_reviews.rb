class TruncateReviews < ActiveRecord::Migration
  def up
    Review.delete_all
  end

  def down
  end
end
