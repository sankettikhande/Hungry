class CookingToday < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  belongs_to :cheff
  belongs_to :food_item

  validates :food_item_id, :presence => true
  validates :cheff_id, :presence => true
  validates :date, :presence => true

  def name
    "Chef: #{self.cheff.chef_coordinate.name} | Dish: #{self.food_item.meal_info.name} " if self.cheff && self.food_item
  end

  def self.sorted_by_qty_left
    CookingToday.where(:date =>Time.current.to_date).sort_by(&:qty_left).reverse
  end

  def qty_left
    return (self.quantity - self.ordered)
  end

end
