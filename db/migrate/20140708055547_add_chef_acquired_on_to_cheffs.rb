class AddChefAcquiredOnToCheffs < ActiveRecord::Migration
  def change
    add_column :cheffs, :chef_acquired_on, :date
  end
end
