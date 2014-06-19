class RemoveSubHeading < ActiveRecord::Migration
  def up
    remove_column :ingredients, :sub_heading
    remove_column :prepration_steps, :sub_heading

  end

  def down
  end
end
