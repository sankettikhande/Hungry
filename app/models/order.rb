class Order < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  has_many :ordered_menus

  #validates :name, :presence => true
  #validates :address, :presence => true
  validates :date, :presence => true
  #validates :phone_no, :presence => true
end
