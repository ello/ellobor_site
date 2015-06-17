class PagesController < ApplicationController

  def index
    if cookies[:signatory_info].present?
      signatory_info = ActiveSupport::JSON.decode(cookies[:signatory_info])
      @signatory = Signatory.new(name: signatory_info["name"], website: website, email: email)
    end
  end
  
end
