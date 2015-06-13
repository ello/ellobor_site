class ErrorsController < ActionController::Base
  layout 'errors_base'

  def not_found_404
  end

  def internal_error_500
  end

  def unprocessable_entity_422
  end

end
