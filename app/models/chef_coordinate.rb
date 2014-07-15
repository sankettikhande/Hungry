class ChefCoordinate < ActiveRecord::Base
  belongs_to :cheff
  attr_accessible :cheff_id, :name, :address_line_1, :address_line_2, :locality, :landmark, :city, :zip, :longitude,
                  :latitude, :contact_mobile, :contact_landline, :contact_email
  validates_presence_of :name

end
