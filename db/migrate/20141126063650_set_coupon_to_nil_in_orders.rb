class SetCouponToNilInOrders < ActiveRecord::Migration
  def up
    Order.where(coupon_id: 0).update_all("coupon_id = NULL")
  end

  def down
  end
end
