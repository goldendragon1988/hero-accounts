class ApiController < ActionController::API
  include UserConcern
  include ResponseConcern

  before_action :authenticate_user!

  respond_to :json
end
