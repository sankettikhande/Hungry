class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :coupon_code
      t.string :coupon_type
      t.integer :no_of_coupons, :default => 0
      t.integer :no_of_used_coupons, :default => 0
      t.timestamps
    end
  end
end
