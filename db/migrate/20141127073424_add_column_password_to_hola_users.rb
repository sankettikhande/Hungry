class AddColumnPasswordToHolaUsers < ActiveRecord::Migration
  def change
    add_column :hola_users, :password, :string
  end
end
