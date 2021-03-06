class Coupon < ActiveRecord::Base
  attr_accessor :skip_callbacks
  acts_as_content_block({:versioned => false})
  
  attr_accessible :coupon_code
  has_and_belongs_to_many :hola_users, :join_table => "hola_user_coupons", :foreign_key => "coupon_id"
  has_many :orders

  validates :coupon_code, :coupon_type, :no_of_coupons,  presence: true
  validates :percentage, :presence => true, if: Proc.new { |p| p.flat.blank? }
  validates :flat, :presence => true, if: Proc.new { |p| p.percentage.blank? }
  validates :coupon_code, :uniqueness => true

  def self.calculate_percentage(amount,per)
    amount = ((per.to_f / 100) * amount.to_i).to_i
    return amount
  end

  def check_coupons_validity(user_id, app_request)
    coupon = Coupon.find_by_coupon_code(self.coupon_code)
    return if coupon.blank?
    return "Not a valid coupon."  if  coupon.no_of_coupons <= coupon.no_of_used_coupons
    if coupon.coupon_type == '1U1T'
      coupon_used_count = HolaUserCoupon.where(:coupon_id => coupon.id, :hola_user_id => user_id).count
      if app_request
        return coupon_used_count > 1 ? "#{self.coupon_code} coupon already used." : ""
      else
        return coupon_used_count > 0 ? "#{self.coupon_code} coupon already used." : ""
      end
    end
    if coupon.coupon_type == '3D'
      confirm_order_count = HolaUser.confirm_orders_last_3_days(user_id)
      return confirm_order_count && confirm_order_count > 0 ? "" : "You can't use this #{self.coupon_code} coupon code."
    end
  end

  def discount total = nil
    coupon_discount_type = flat.blank? ? "percentage" : "flat"
    coupon_discount_type == "flat" ? flat : Coupon.calculate_percentage(total, percentage)
  end
end
