class AddColumnsToFeedbacks < ActiveRecord::Migration
  def change
    add_column :feedbacks, :name, :string
    add_column :feedbacks, :contact_no, :string
    add_column :feedbacks, :published, :boolean, :default => false
    add_column :feedbacks, :deleted, :boolean, :default => false
    add_column :feedbacks, :archived, :boolean, :default => false
    add_column :feedbacks, :created_by_id, :integer
    add_column :feedbacks, :updated_by_id, :integer
  end
end
