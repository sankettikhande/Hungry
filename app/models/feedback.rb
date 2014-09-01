class Feedback < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks
  attr_accessible :feedback, :email, :contact_no, :name

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :contact_no
  validates_presence_of :feedback

  def self.display_name
    "Talk to Us"
  end

end

