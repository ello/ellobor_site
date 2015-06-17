if Secrets.mailchimp_key.present?
  MAILCHIMP_API_KEYS = {
    key: "#{Secrets.mailchimp_key}",
    list_id: "#{Secrets.mailchimp_list_id}"
  }
end
