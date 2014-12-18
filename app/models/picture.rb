require 'pp'
class Picture < ActiveRecord::Base
  belongs_to :picturable, :polymorphic => true

  attr_accessible :image_content_type, :image_file_name, :image_file_size, :image
  has_attached_file :image, :styles =>
                              {:thumb => "60x60>", :medium => "120x120>"}

  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg)

  validates_presence_of :image
end