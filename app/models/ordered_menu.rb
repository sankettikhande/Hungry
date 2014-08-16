class OrderedMenu < ActiveRecord::Base

  belongs_to :order
  belongs_to :food_item, foreign_key: :dish_id
  belongs_to :cheff

  attr_accessible :order_id, :dish_id, :cheff_id, :quantity, :rate

  validates :order_id, :presence => true
  validates :cheff_id, :presence => true
  validates :dish_id, :presence => true
  validates :quantity, :presence => true


  def self.calculate_total(order)
    menus = order.ordered_menus
    total_price = 0
    menus.each do |menu|
      total_price = total_price + (menu.rate * menu.quantity)
    end
    return total_price
  end

  def ordered_menu_bill
    rate * quantity
  end
end
