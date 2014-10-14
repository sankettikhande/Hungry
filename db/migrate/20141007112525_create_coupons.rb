class CreateCoupons < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "Coupon", :group_name => "Coupon")
    create_content_table :coupons, :prefix=>false do |t|
      t.string :coupon_code
      t.string :coupon_type
      t.integer :no_of_coupons, :default => 0
      t.integer :no_of_used_coupons, :default => 0
      t.integer :percentage
      t.integer :flat
      t.timestamps
      t.timestamps
    end
  end
end
