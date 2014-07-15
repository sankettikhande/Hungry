class CreateChefCoordinates < ActiveRecord::Migration
  def change
    create_table :chef_coordinates do |t|
      t.integer :cheff_id
      t.string :name
      t.text :address_line_1
      t.text :address_line_2
      t.string :locality
      t.string :landmark
      t.string :city
      t.integer :zip
      t.float :longitude
      t.float :latitude
      t.string :contact_mobile
      t.string :contact_landline
      t.string :contact_email
      t.timestamps
    end
  end
end
