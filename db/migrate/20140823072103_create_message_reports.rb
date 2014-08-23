class CreateMessageReports < ActiveRecord::Migration
  def change
    create_table :message_reports do |t|
    	t.string :message_type
    	t.string :numbers
    	t.string :status
    	t.text :message
    	t.string :message_id

      t.timestamps
    end
  end
end
