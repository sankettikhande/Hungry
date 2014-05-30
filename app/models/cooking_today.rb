class CookingToday < ActiveRecord::Base
  acts_as_content_block

  belongs_to :cheff
  belongs_to :dish

  validates :dish_id, :presence => true
  validates :cheff_id, :presence => true

  def name
    "Cheff: #{self.cheff.name} | Dish: #{self.dish.name} "
  end

end
