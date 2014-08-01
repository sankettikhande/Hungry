class HolaUserAddress < ActiveRecord::Base
  belongs_to :hola_user
  attr_accessible :address, :hola_user_id, :address_type, :name, :building_name, :street, :city, :pin, :landmark, :default
end
