class HolaUserAddress < ActiveRecord::Base
  belongs_to :hola_user
  attr_accessible :address, :hola_user_id
end
