class MessageReport < ActiveRecord::Base
	attr_accessible :numbers, :message, :message_type, :status, :message_id
end
