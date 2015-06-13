class MailchimpListSyncWorker
  
  include Sidekiq::Worker
  if Rails.env.development?
    sidekiq_options retry: 0
  else
    sidekiq_options retry: 2
  end

  ## Mailchimp Segment(s) we're using - setting source
  # Newsletter
  
  def perform(email, first_name, last_name, type, operation_type, source, old_email)
    unless (email.include?("customer.com") || email.include?("test.com")) && !Secrets.mail_catcher.present?
      double_optin = type != "quiet"

      if operation_type == "add"
        gb = Gibbon::API.new(MAILCHIMP_API_KEYS[:key])
        begin
          response = gb.lists.subscribe({id: MAILCHIMP_API_KEYS[:list_id], email: {email: "#{email}"}, merge_vars: {FNAME: "#{first_name}", LNAME: "#{last_name}", SOURCE: "#{source}"}, double_optin: double_optin})
        rescue Gibbon::MailChimpError => e
          if e.to_s.include? "is already subscribed"
            response = gb.lists.subscribe({id: MAILCHIMP_API_KEYS[:list_id], email: {email: "#{email}"}, merge_vars: {FNAME: "#{first_name}", LNAME: "#{last_name}", SOURCE: "#{source}"}, update_existing: true, double_optin: double_optin})
          end
        end
      elsif operation_type == "update"
        gb = Gibbon::API.new(MAILCHIMP_API_KEYS[:key])
        response = gb.lists.subscribe({id: MAILCHIMP_API_KEYS[:list_id], email: {email: "#{email}"}, merge_vars: {FNAME: "#{first_name}", LNAME: "#{last_name}", SOURCE: "#{source}"}, update_existing: true, double_optin: double_optin})
      elsif operation_type == "change"
        gb = Gibbon::API.new(MAILCHIMP_API_KEYS[:key])
        response = gb.lists.unsubscribe(id: MAILCHIMP_API_KEYS[:list_id], email: {email: "#{old_email}"}, delete_member: true, send_notify: false) #rescue nil
        response = gb.lists.subscribe({id: MAILCHIMP_API_KEYS[:list_id], email: {email: "#{email}"}, merge_vars: {FNAME: "#{first_name}", LNAME: "#{last_name}", SOURCE: "#{source}"}, update_existing: true, double_optin: double_optin})
      else
        gb = Gibbon::API.new(MAILCHIMP_API_KEYS[:key])
        response = gb.lists.unsubscribe({id: MAILCHIMP_API_KEYS[:list_id], email: {email: "#{email}"}, delete_member: true, send_notify: false})
      end
    end
  end
  
end
