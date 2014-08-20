class Runner < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  attr_accessor :skip_callbacks

  has_many :orders

  validates :name, :phone, :address, presence: true
end
