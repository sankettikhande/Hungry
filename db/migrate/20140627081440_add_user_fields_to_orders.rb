class AddUserFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :firstName, :string
    add_column :orders, :lastName, :string
    add_column :orders, :email, :string
    add_column :orders, :addressStreet1, :string
    add_column :orders, :addressStreet2, :string
    add_column :orders, :addressCity, :string
    add_column :orders, :addressState, :string
    add_column :orders, :addressCountry, :string
    add_column :orders, :addressZip, :string
  end
end
