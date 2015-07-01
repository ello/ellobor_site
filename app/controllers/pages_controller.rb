class PagesController < ApplicationController

  def index
    if cookies[:signatory_info].present?
      signatory_info = ActiveSupport::JSON.decode(cookies[:signatory_info])
      @signatory = Signatory.new(name: signatory_info["name"], website: signatory_info["website"], email: signatory_info["email"])
      @num_signatures = Signatory.verified.count
    end
  end

  def load_signatories
    page = params[:page] || 1
    @signatories = Signatory.verified.page(page).order('verified_at DESC')
  end
  
end
