module UserConcern
  extend ActiveSupport::Concern
  include ActionController::HttpAuthentication::Token::ControllerMethods

  included do
    before_action :authenticate_user
  end

  def authenticate_user
    return if request.headers['Authorization'].blank?

    authenticate_or_request_with_http_token do |token|
      jwt_payload = JWT.decode(token, Rails.application.secret_key_base).first

      @current_user_id = jwt_payload['id']
    rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
      head(:unauthorized)
    end
  end

  def authenticate_user!(_options = {})
    head(:unauthorized) unless signed_in?
  end

  def current_user
    @current_user ||= UserDecorator.new(User.find_by(id: @current_user_id))
  end

  def signed_in?
    @current_user_id.present?
  end
end
