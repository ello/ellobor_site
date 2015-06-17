class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_cache_buster

  ## developer mode
  def set_development_mode_session_var
    session['development_mode'] = true
    render text: "SET: session['development_mode'] = true"
  end

  def unset_development_mode_session_var
    session['development_mode'] = false
    render text: "SET: session['development_mode'] = false"
  end
  ## END developer mode

  private

    def set_cache_buster # this stops Chrome from showing ajax call fragments when the user invokes the back-button
      if request.xhr?
        response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
      end
    end

    def render_404
      raise ActionController::RoutingError.new('Not Found')
    end

end
