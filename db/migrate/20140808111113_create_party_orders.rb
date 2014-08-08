class CreatePartyOrders < ActiveRecord::Migration
  def change
    create_table :party_orders do |t|
      t.text :details
      t.string :name, null: false
      t.string :contact_no, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
