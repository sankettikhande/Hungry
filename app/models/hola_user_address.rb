class HolaUserAddress < ActiveRecord::Base
  belongs_to :hola_user
  attr_accessible :address, :hola_user_id, :address_type, :name, :building_name, :street, :city, :pin, :landmark, :default, :mobile_no, :landline_no

  scope :default_address, where(default: true)

  def address_array
    [building_name, street, landmark, pin].compact.reject { |c| c.empty? }
  end

  def address_to_string
    address_array.join(", ")
  end
end
