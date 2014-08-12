class AddContactNosHolaUserAddresses < ActiveRecord::Migration
  def change
    add_column :hola_user_addresses, :mobile_no, :string, null: false
    add_column :hola_user_addresses, :landline_no, :string
  end
end
