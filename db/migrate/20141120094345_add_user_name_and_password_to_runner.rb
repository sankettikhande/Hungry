class AddUserNameAndPasswordToRunner < ActiveRecord::Migration
  def change
    add_column :runners, :username, :string
    add_column :runners, :password, :string
  end
end
