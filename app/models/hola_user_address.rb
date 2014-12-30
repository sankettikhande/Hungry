class HolaUserAddress < ActiveRecord::Base

  @@pin_codes = ["400042", "400059", "400060", "400076", "400078", "400072","400079", "400086", "400087","400093","400096"]
  cattr_accessor :pin_codes
  attr_accessible :address, :hola_user_id, :address_type, :name, :building_name, :street, :city, :pin, :landmark, :default, :mobile_no, :landline_no, :area, :sub_area

  belongs_to :hola_user

  scope :default_address, where(default: true)

  def address_array
    [building_name, street, landmark, pin].compact.reject { |c| c.empty? }
  end

  def address_to_string
    address_array.join(", ")
  end
end
