class PartyOrder < ActiveRecord::Base
  attr_accessible :details, :name, :contact_no, :email
end
