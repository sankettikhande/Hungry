require 'net/http'

module MessagingLib
	class << self
		def send_messages(message,numbers,message_type)
			encode_msg = message.split(' ').join('+')
			url = Settings.messaging_default_url + "&to=#{numbers}&message=#{encode_msg}"
			result = Net::HTTP.get(URI.parse(url))
			id = (result.include?("Message") ? result.split(" ID=").last : nil)
			message = MessageReport.create(:numbers => numbers, :message_type => message_type, :message => message, :message_id => id, :status => result)
			if id
				retrace_url = Settings.messaging_default_retrace_url + "&messageid=#{id}"
				status = Net::HTTP.get(URI.parse(retrace_url)).split("\n").last
				message.update_attribute(:status, status)
			end
		end
	end
end