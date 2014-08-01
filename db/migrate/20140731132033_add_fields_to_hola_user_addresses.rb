class AddFieldsToHolaUserAddresses < ActiveRecord::Migration
  def change
    add_column :hola_user_addresses, :address_type, :string
    add_column :hola_user_addresses, :name, :string
    add_column :hola_user_addresses, :building_name, :string
    add_column :hola_user_addresses, :street, :string
    add_column :hola_user_addresses, :city, :string
    add_column :hola_user_addresses, :pin, :string
    add_column :hola_user_addresses, :landmark, :string
    add_column :hola_user_addresses, :default, :boolean, default: false
  end
end
