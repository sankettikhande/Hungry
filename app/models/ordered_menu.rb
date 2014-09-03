class OrderedMenu < ActiveRecord::Base
  @@order_statuses = ["Ordered", "Delivered", "Canceled", "Damaged", "Returned"]

  belongs_to :order
  belongs_to :food_item, foreign_key: :dish_id
  belongs_to :cheff

  attr_accessible :order_id, :dish_id, :cheff_id, :quantity, :rate

  validates :order_id, :presence => true
  validates :cheff_id, :presence => true
  validates :dish_id, :presence => true
  validates :quantity, :presence => true
  validates :order_status, presence: true, inclusion: { in: @@order_statuses }


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

  def cooking_today
    CookingToday.where(date: Time.current.to_date, food_item_id: dish_id)
  end
end
