class Banner < ActiveRecord::Base
  acts_as_content_block({:versioned => false})
  @@banner_types = ["Text", "Image"]
  @@pages_to_display_list = ["Home", "Review Order", "Add Address"]
  cattr_reader :banner_types, :pages_to_display_list
  attr_accessor :skip_callbacks
  has_attachment :banner_image

  serialize :pages_to_display, Array

  validates :name, :banner_types, :start_date, :end_date, :height, :width, :pages_to_display, presence: true
end
