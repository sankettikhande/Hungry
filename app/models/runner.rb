class Runner < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  has_many :orders

  validates :name, :phone, :address, presence: true
  validates :username, uniqueness: true

  before_save :encode_password

  def amount_pending
    orders_pending.collect{|a| a.total.to_i}.reduce(:+)
  end

  def cash_collected
    orders_delivered.collect{|a| a.total.to_i}.reduce(:+)
  end

  def orders_pending
    orders.select{|a| a.order_status == "Confirmed"}.compact
  end

  def orders_delivered
    orders.select{|a| a.order_status == "Delivered"}.compact
  end

  def damaged_count
    orders.select{|a| a.order_status == "Damaged"}.compact.count
  end

  def returned_count
    orders.select{|a| a.order_status == "Returned"}.compact.count
  end

  def average_delivery_time
    delivery_times = []
    orders_delivered.each do |o|
      delivery_times << o.delivery_time.to_i
    end
    return "" if delivery_times.blank?
    Time.at(delivery_times.inject{ |sum, el| sum + el }.to_f / delivery_times.size).utc.strftime("%H:%M:%S")
  end

  def encode_password
    enc   = Base64.encode64(self.password)
    self.password = enc
  end

end
