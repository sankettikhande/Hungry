class AddAreaToAddresses < ActiveRecord::Migration
  def change
    add_column :hola_user_addresses, :area, :string unless column_exists?(:hola_user_addresses, :area)
    add_column :hola_user_addresses, :sub_area, :string unless column_exists?(:hola_user_addresses, :sub_area)

    add_column :orders, :area, :string unless column_exists?(:orders, :area)
    add_column :orders, :sub_area, :string unless column_exists?(:orders, :sub_area)

  end
end
