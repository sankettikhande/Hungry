class CreateFeedbackContentType < ActiveRecord::Migration
  def change
    Cms::ContentType.create!(:name => "Feedback", :group_name => "Feedback")
  end

end
