class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :food_item_id
      t.date :review_date
      t.string :reviewer
      t.text :review
      t.integer :ratings, :default => 0

      t.timestamps
    end
  end
end
