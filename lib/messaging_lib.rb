require 'net/http'

module MessagingLib
	class << self
		def send_messages(message,numbers,message_type)
        return  if (Rails.env.qa? && !['9975603230','7498444566'].include?(numbers))
        encode_msg = message.split(' ').join('+')
        url = Settings.messaging_default_url + "&send_to=#{numbers}&msg=#{encode_msg}"
        result = Net::HTTP.get(URI.parse(url))
        id = (result.include?("success") ? result.split("|").last.strip : nil)
        MessageReport.create(:numbers => numbers, :message_type => message_type, :message => message, :message_id => id, :status => result)
      end
	end
end
