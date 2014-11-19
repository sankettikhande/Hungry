class Coupon < ActiveRecord::Base
  attr_accessor :skip_callbacks
  acts_as_content_block({:versioned => false})
  
  acts_as_content_block
  attr_accessible :coupon_code
  has_and_belongs_to_many :hola_users, :join_table => "hola_user_coupons", :foreign_key => "coupon_id"

  validates :coupon_code, :coupon_type, :no_of_coupons,  presence: true
  validates :percentage, :presence => true, if: Proc.new { |p| p.flat.blank? }
  validates :flat, :presence => true, if: Proc.new { |p| p.percentage.blank? }
  validates :coupon_code, :uniqueness => true

  def self.calculate_percentage(amount,per)
    amount = ((per.to_f / 100) * amount.to_i).to_i
    return amount
  end

  def check_coupons_validity(user_id)
    coupon = Coupon.find_by_coupon_code(self.coupon_code)
    return if coupon.blank?
    return "You can not use this coupon. validity Reached"  if  !coupon.blank? && (coupon.no_of_coupons == coupon.no_of_used_coupons)
    if coupon.coupon_type == '1U1T'
      user_coupon = HolaUserCoupon.where(:coupon_id => coupon.id, :hola_user_id => user_id).first
      return user_coupon.blank? ? "" : "#{self.coupon_code} coupon already used."
    end
    if coupon.coupon_type == '3D'
      confirm_order_count = HolaUser.confirm_orders_last_3_days(user_id)
      return confirm_order_count && confirm_order_count > 0 ? "" : "You can't use this #{self.coupon_code} coupon code."
    end
  end
end
