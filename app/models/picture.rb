require 'pp'
class Picture < ActiveRecord::Base
  belongs_to :picturable, :polymorphic => true

  attr_accessible :image_content_type, :image_file_name, :image_file_size, :image
  has_attached_file :image,
                    :styles =>
                        {:thumb => "60x60>", :medium => "120x120>"},
                    :storage => :s3,
                    :s3_credentials => "#{::Rails.root.to_s}/config/aws.yml",
                    :s3_permissions => "public-read",
                    :url => ':s3_alias_url',
                    :path => "/:class/:attachment/:id_partition/:style/:filename",
                    :s3_host_alias => Settings.cloud_front_url,
                    :s3_protocol => :http,
                    :s3_headers => {'Expires' => (Time.now + 60*60*24*30*12).httpdate}

  validates_attachment_content_type :image, :content_type => %w(image/jpeg image/jpg/ image/png image/gif)

  validates_presence_of :image
end