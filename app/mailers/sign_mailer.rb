class SignMailer < ApplicationMailer

  helper :sign_helper
  
  def send_verification(signatory_id)
    @signatory = Signatory.find(signatory_id)
    if @signatory.present? && @signatory.verification_sent_at.blank?
      unless dev_email?(@signatory.email)
        @subject = "Verify Signing #{Secrets.base_site_title}"
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
