class CreateTemporaryHomes < ActiveRecord::Migration
  def change
    create_table :temporary_homes do |t|
      t.string :email

      t.timestamps
    end
  end
end
