class ChangeColumnAddressTypeToDefaultHome < ActiveRecord::Migration
  def up
    change_column :hola_user_addresses, :address_type, :string, default: "Home"
  end

  def down
    change_column :hola_user_addresses, :address_type, :string
  end
end
