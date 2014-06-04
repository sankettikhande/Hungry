class CreateOrderedMenus < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "OrderedMenu", :group_name => "OrderedMenu")
    create_content_table :ordered_menus, :prefix=>false do |t|
      t.integer :order_id
      t.integer :cheff_id
      t.integer :dish_id
      t.integer :quantity
      t.integer :rate

      t.timestamps
    end
  end
end
