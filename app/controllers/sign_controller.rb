class SignController < ApplicationController

  def sign
    if request.xhr?
      params[:signatory][:ip_address] = request.remote_ip
      @signatory = Signatory.new(signatory_params)
      if @signatory.valid?
        @signatory.save
      else
        @error = true
      end

      ## set/update info to cookie to reflect previous signing
      submitter_info = {
        name: @signatory.name,
        email: @signatory.email,
        website: @signatory.website
      }
      cookies[:submitter_info] = {
        value: submitter_info.to_json,
        expires: (Time.now + 90.days)  
      }
    end
  end

  private

    def signatory_params
      params.require(:signatory).permit(:website, :name, :email, :ip_address)
    end

end
