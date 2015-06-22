class SignController < ApplicationController

  # todo - check for repeat signing - update info, resend email

  def new
    if request.xhr?
      params[:signatory][:ip_address] = request.remote_ip

      # check for existing email / we will update & re-send verification if it exists
      existing_signatory = Signatory.where(email: params[:signatory][:email]).first
      if existing_signatory.blank?
        @signatory = Signatory.new(signatory_params)
        if @signatory.valid?
          @signatory.save
        else
          @error = true
        end
      else
        existing_signatory.update(verification_sent_at: nil, verified_at: nil)
        @signatory = existing_signatory
        @signatory.update(signatory_params)
      end

      ## set/update info to cookie to reflect previous signing
      signatory_info = {
        name: @signatory.name,
        email: @signatory.email,
        website: @signatory.website
      }
      cookies[:signatory_info] = {
        value: signatory_info.to_json,
        expires: (Time.now + 90.days)  
      }
    end
  end

  def verify
    @signatory = Signatory.find_by_lookup_token(params[:token])
    if @signatory.present?
      @signatory.update(verified_at: Time.zone.now)
    else
      render_404
    end
  end

  def unsubscribe
    @signatory = Signatory.find_by_lookup_token(params[:token])
    if @signatory.present?
      @signatory.update(unsubscribed_at: Time.zone.now)
    else
      render_404
    end
  end

  private

    def signatory_params
      params.require(:signatory).permit(:website, :name, :email, :ip_address)
    end

end
