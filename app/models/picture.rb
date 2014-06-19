class Picture < ActiveRecord::Base
  belongs_to :picturable, :polymorphic=> true

  attr_accessible :image_content_type, :image_file_name, :image_file_size, :image
  has_attached_file :image

  validates_presence_of :image
end