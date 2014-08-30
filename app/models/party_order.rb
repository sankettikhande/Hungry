class PartyOrder < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks
  attr_accessible :details, :name, :contact_no, :email

  validates :name, :presence => true
  validates :contact_no, :presence => true
  validates :email, :presence => true
end
