Rails.application.configure do
  # Set host for devise email
  config.action_mailer.default_url_options = { host: Secrets.app_url }

  if Secrets.mail_catcher.present? && Secrets.mail_catcher
    config.action_mailer.delivery_method   = :smtp
    config.action_mailer.smtp_settings     = { :address => "localhost", :port => 1025 }
  elsif Secrets.postmark_key.present?
    config.action_mailer.delivery_method   = :postmark
    config.action_mailer.postmark_settings = { api_key: "#{Secrets.postmark_key}" }
  else
    ActionMailer::Base.smtp_settings = {
    address:               "#{Secrets.email_address}",
    port:                  Secrets.email_port,
    domain:                "#{Secrets.email_domain}",
    user_name:             "#{Secrets.email_username}",
    password:              "#{Secrets.email_password}",
    authentication:        "#{Secrets.email_authentication}",
    enable_starttls_auto:  true
    }
  end
end
