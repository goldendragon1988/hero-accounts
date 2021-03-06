class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true, unless: :json_request?
  protect_from_forgery with: :null_session, if: :json_request?
  skip_before_action :verify_authenticity_token, if: :json_request?
  rescue_from ActionController::InvalidAuthenticityToken, with: :invalid_auth_token

  private

  def json_request?
    request.format.json?
  end

  def invalid_auth_token
    respond_to do |format|
      format.html { redirect_to(admin_users_sign_in_path, error: 'Login invalid or expired') }
      format.json { head(401) }
    end
  end
end
