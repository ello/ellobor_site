class ApplicationMailer < ActionMailer::Base
  
  before_filter :set_defaults
  after_filter :set_mail_settings
  
  # helper :application

  layout "email"

  private

  def set_defaults
    @cancel_send = false
    @bcc = false
  end

  def set_mail_settings
    unless @cancel_send
      subject = @subject || company_name
      if @bcc && @signatory_email.class.to_s == "Array"
        signatory_email = @signatory_email.shift
        bcc_emails = @signatory_email
      else
        signatory_email = @signatory_email
        bcc_emails = []
      end
      mail(
        from: from,
        reply_to: reply_email,
        to: signatory_email,
        bcc: bcc_emails,
        subject: @subject
      )
    end
  end

  def dev_email?(email)
    (email.include?("customer.com") || email.include?("test.com")) && !Secrets.mail_catcher.present?
  end

  def company_name
    Secrets.base_company_name
  end

  def reply_email
    if Secrets.general_email_address.present?
      reply_email = Secrets.general_email_address
    else
      reply_email = "support@ello.co"
    end
  end

  def from
    "#{company_name} <#{reply_email}>"
  end

end
