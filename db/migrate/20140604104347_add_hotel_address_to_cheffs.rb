class AddHotelAddressToCheffs < ActiveRecord::Migration
  def change
    add_column :cheffs, :hotel_name, :string
    add_column :cheffs, :address, :string
    add_column :cheff_versions, :hotel_name, :string
    add_column :cheff_versions, :address, :string
  end
end
