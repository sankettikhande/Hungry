class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.text :feedback, null: false
      t.string :email, null: false
      t.timestamps
    end
  end
end
