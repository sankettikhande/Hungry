class CookingToday < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  belongs_to :cheff
  belongs_to :dish

  validates :dish_id, :presence => true
  validates :cheff_id, :presence => true
  validates :date, :presence => true

  def name
    "Cheff: #{self.cheff.name} | Dish: #{self.dish.name} "
  end

end
