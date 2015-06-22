class SignMailer < ApplicationMailer

  helper :sign
  
  def send_verification(signatory_id)
    @signatory = Signatory.find(signatory_id)
    if @signatory.present? && @signatory.verification_sent_at.blank?
      unless dev_email?(@signatory.email) || @signatory.unsubscribed_at.present?
        @subject = "Verify Signing #{Secrets.base_site_title}"
        @signatory_email = @signatory.email
        @signatory.update(verification_sent_at: Time.zone.now)
      else
        @cancel_send = true
        return false
      end
    else
      @cancel_send = true
    end
  end

end
