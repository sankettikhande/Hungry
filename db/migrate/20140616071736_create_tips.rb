class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.integer :dish_id
      t.text :tips

      t.timestamps
    end
  end
end
