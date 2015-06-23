class SendVerificationEmailWorker
  
  include Sidekiq::Worker
  if Rails.env.development?
    sidekiq_options retry: 0
  else
    sidekiq_options retry: 2
  end

  def perform(signatory_id)
    ## send the email
    SignMailer.send_verification(signatory_id).deliver_now
  end
  
end
