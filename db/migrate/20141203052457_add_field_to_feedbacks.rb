class AddFieldToFeedbacks < ActiveRecord::Migration
  def change
  	add_column :feedbacks, :is_chef, :boolean, :default => false
  end
end
