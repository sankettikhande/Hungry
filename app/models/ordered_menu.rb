class OrderedMenu < ActiveRecord::Base
  @@order_statuses = ["Ordered", "Delivered", "Canceled", "Damaged", "Returned"]

  belongs_to :order
  belongs_to :food_item, foreign_key: :dish_id
  belongs_to :cheff
  belongs_to :cooking_today

  attr_accessible :order_id, :dish_id, :cheff_id, :quantity, :rate, :cooking_today_id

  validates :order_id, :presence => true
  validates :cheff_id, :presence => true
  validates :dish_id, :presence => true
  validates :quantity, :presence => true
  validates :order_status, presence: true, inclusion: { in: @@order_statuses }

  after_save :add_back_quantity, :if => Proc.new {|o| o.order.order_status != "Created" and o.order_status_changed? and o.canceled?}

  @@order_statuses.each do |s|
    define_method "#{s.downcase}?" do
      order_status == s
    end
  end

  def self.calculate_total(order,dis_amt,meal_length)
    if (order.parent_order_id.blank? && meal_length > 1)
      order = Order.where(:parent_order_id => order.id)
      total_price = 0
      if !order.blank?
        order.each do |order|
            total_price = total_price + (order.total)
        end
      end
      return  total_price
    else
      menus = order.ordered_menus
      total_price = 0
      menus.each do |menu|
        total_price = total_price + (menu.rate * menu.quantity)
      end
      total_price = total_price.to_i - dis_amt.to_i  if (!dis_amt.blank? )
      return total_price
    end
  end

  def self.calculate_mrp(order)
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

  def add_back_quantity
    cooking_today.update_attributes(ordered: (cooking_today.ordered - self.quantity)) if (cooking_today.ordered - self.quantity) >= 0
  end

  def self.restore_ordered_menus updated_ordered_menus
    updated_ordered_menus.each do |ordered_menu|
      cooking_today = ordered_menu.cooking_today
      cooking_today.update_attribute(:ordered, (cooking_today.ordered - ordered_menu.quantity))
      decrease_food_items_served_count
    end
  end

  def increase_food_items_served_count
    food_item.update_attribute(:dish_served, food_item.dish_served.to_i + quantity.to_i)
  end

  def decrease_food_items_served_count
    food_item.update_attribute(:dish_served, food_item.dish_served.to_i - quantity.to_i) if food_item.dish_served > 0
  end
end
