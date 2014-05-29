class Cheff < ActiveRecord::Base
  acts_as_content_block

  has_many :dishes

  validate :name, :presence => true
end
