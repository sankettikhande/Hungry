class CreateHolaUserAddresses < ActiveRecord::Migration
  def change
    create_table :hola_user_addresses do |t|
      t.string :address
      t.integer :hola_user_id
      t.timestamps
    end
  end
end
