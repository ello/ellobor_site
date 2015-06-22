module SignHelper

  def verification_link(lookup_token)
    "https://#{Secrets.app_url}/sign/verify/#{lookup_token}"
  end

  def ello_link
    "https://#{Secrets.parent_url}"
  end

  def ios_app_link
    Secrets.ios_app_link
  end

end
