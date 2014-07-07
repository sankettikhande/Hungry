class HolaUser < ActiveRecord::Base
  has_many :hola_user_addresses
  attr_accessible :name, :phoneNumber

  validates :phoneNumber, :uniqueness => true
end
