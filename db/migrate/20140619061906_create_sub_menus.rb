class CreateSubMenus < ActiveRecord::Migration
  def change
    create_table :sub_menus do |t|
      t.integer :dish_id
      t.string :title

      t.timestamps
    end
  end
end
