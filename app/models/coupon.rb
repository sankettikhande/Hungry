class Coupon < ActiveRecord::Base
  acts_as_content_block
  attr_accessible :coupon_code
  has_and_belongs_to_many :hola_users, :join_table => "hola_user_coupons", :foreign_key => "coupon_id"

  validates :coupon_code, :coupon_type, :no_of_coupons,  presence: true
  validates :percentage, :presence => true, if: Proc.new { |p| p.flat.blank? }
  validates :flat, :presence => true, if: Proc.new { |p| p.percentage.blank? }

  def self.calculate_percentage(amount,per)
    amount = ((per.to_f / 100) * amount.to_i).to_i
    return amount
  end

  def check_coupons_validity(user_id)
      coupon = Coupon.find_by_coupon_code(self.coupon_code)
      if !coupon.blank?
        if (coupon.no_of_coupons == coupon.no_of_used_coupons)
          return "You can not use this coupon. validity Reached"
        else
          if coupon.coupon_type == '1U1T' && !coupon.hola_users.blank?
           user_coupon = coupon.hola_users.where(:id =>  user_id)
           return user_coupon.blank? ? "" : "#{self.coupon_code} coupon already used."
          end
        end
      end
  end
end