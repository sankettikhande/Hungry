class AddOrderIdToReviews < ActiveRecord::Migration
  def change
  	  add_column :reviews, :order_id, :integer
  end
end
