class AddCouponIdOrders < ActiveRecord::Migration
  def up
    add_column :orders, :coupon_id, :integer
    add_column :orders, :mrp, :integer
  end

  def down
    remove_column :orders, :coupon_id
    remove_column :orders, :mrp
  end
end
