class CreateHolaUserCoupons < ActiveRecord::Migration
  def change
    create_table :hola_user_coupons do |t|
      t.integer :hola_user_id
      t.integer :coupon_id
      t.timestamps
    end
    add_index :hola_user_coupons, [:hola_user_id, :coupon_id]
  end
end
