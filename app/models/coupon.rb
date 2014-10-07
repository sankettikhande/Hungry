class Coupon < ActiveRecord::Base
  acts_as_content_block
  attr_accessible :coupon_code

  validates :coupon_code, presence: true

  has_many :hola_users

  def self.calculate_percentage(amount,per)
    amount = ((per.to_f / 100) * amount.to_i).to_i
    return amount
  end
end
