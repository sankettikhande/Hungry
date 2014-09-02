class AddColumnToPartyOrders < ActiveRecord::Migration
  def change
    add_column :party_orders, :published, :boolean, :default => false
    add_column :party_orders, :deleted, :boolean, :default => false
    add_column :party_orders, :archived, :boolean, :default => false
    add_column :party_orders, :created_by_id, :integer
    add_column :party_orders, :updated_by_id, :integer
  end
end
