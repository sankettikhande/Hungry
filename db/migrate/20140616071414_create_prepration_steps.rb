class CreatePreprationSteps < ActiveRecord::Migration
  def change
    create_table :prepration_steps do |t|
      t.integer :dish_id
      t.text :steps
      t.string :sub_heading

      t.timestamps
    end
  end
end
