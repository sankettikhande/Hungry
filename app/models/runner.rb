class Runner < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  has_many :orders

  validates :name, :phone, :address, presence: true

  def amount_pending
    orders_pending.sum(:total)
  end

  def cash_collected
    orders.where(order_status: "Delivered").sum(&:total)
  end

  def orders_pending
    orders.where(order_status: "Confirmed")
  end

  def orders_delivered
    orders.where(order_status: "Delivered")
  end

  def damaged_count
    orders.where(order_status: "Damaged").count
  end

  def returned_count
    orders.where(order_status: "Returned").count
  end

  def average_delivery_time
    delivery_times = []
    orders.where(order_status: "Delivered").each do |o|
      delivery_times << o.delivery_time.to_i
    end
    return "" if delivery_times.blank?
    Time.at(delivery_times.inject{ |sum, el| sum + el }.to_f / delivery_times.size).utc.strftime("%H:%M:%S")
  end
end
