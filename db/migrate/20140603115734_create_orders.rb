class CreateOrders < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "Order", :group_name => "Order")
    create_content_table :orders, :prefix=>false do |t|
      t.string :phone_no
      t.text :address
      t.integer :total
      t.datetime :date
      t.string :status

      t.timestamps
    end
  end
end
