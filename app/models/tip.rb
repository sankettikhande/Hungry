class Tip < ActiveRecord::Base
  belongs_to :dish
  attr_accessible :tips
end
