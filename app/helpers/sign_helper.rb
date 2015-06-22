module SignHelper

  def verification_link(lookup_token)
    "https://#{Secrets.app_url}/sign/verify/#{lookup_token}"
  end

end
