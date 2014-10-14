class HolaUserCoupon < ActiveRecord::Base

  belongs_to :hola_user
  belongs_to :coupon

  validates_uniqueness_of :coupon_id, :scope => :hola_user_id
end
