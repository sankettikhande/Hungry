class ChangeMobileDataType < ActiveRecord::Migration
  def up
    change_column :chef_requests, :mobile_number, :string
  end
end
