class CreateHolaUsers < ActiveRecord::Migration
  def change
    create_table :hola_users do |t|
      t.string :name
      t.string :email
      t.string :phoneNumber
      t.timestamps
    end
  end
end
