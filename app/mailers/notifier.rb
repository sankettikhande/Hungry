class Notifier < ActionMailer::Base

  def send_referal_emails(email_details)
    mail( from: email_details[:from], to: email_details[:recepients], subject: email_details[:subject], :content_type => "text/html") do | format |
      format.html { render text: "<p>#{email_details[:email_body]}</p>" }
    end
  end
end
