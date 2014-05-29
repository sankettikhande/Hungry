class ChangeIfSignatureColumnType < ActiveRecord::Migration
  def up
    change_column :dishes, :if_signature, :boolean, :default => false
  end

  def down
  end
end
