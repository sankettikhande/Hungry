class Review < ActiveRecord::Base
  belongs_to :food_item
  attr_accessible :review_date, :reviewer, :review, :ratings

end
