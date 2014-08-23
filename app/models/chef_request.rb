class ChefRequest < ActiveRecord::Base
  acts_as_content_block

  validates_presence_of :name
  validates_presence_of :mobile_number
  validates_presence_of :email
  validates_presence_of :description
end
