class CreateDishes < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "Dish", :group_name => "Dish")
    create_content_table :dishes, :prefix=>false do |t|
      t.string :name
      t.boolean :if_signature
      t.integer :portions
      t.integer :days_notice
      t.decimal :price, :precision => 2
      t.text :information
      t.timestamps
    end
  end
end
