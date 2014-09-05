class Notifier < ActionMailer::Base

  def send_referal_emails(email_details)
    mail( from: "info@holachef.com", to: email_details[:recepients], subject: email_details[:subject], :content_type => "text/html") do | format |
      format.html { render text: "<p>#{email_details[:email_body]}</p>" }
    end
  end

  def email_invoice_details(email_details, order_id)
    @order = Order.find(order_id)
    mail( from: "info@holachef.com", to: email_details[:recepients], subject: email_details[:subject], :content_type => "text/html") do | format |
      format.html { render :partial => "cms/orders/invoice" }
    end
  end
end
