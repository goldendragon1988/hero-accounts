class V1::SessionsController < Devise::SessionsController
  include ResponseConcern

  respond_to :json

  def create
    user = User.find_by!(email: sign_in_params[:email])

    if user.valid_password?(sign_in_params[:password])
      render_success({ token: user.generate_jwt }, 201)
    else
      render_message('email or password is invalid', :unprocessable_entity)
    end
  rescue ActiveRecord::RecordNotFound => e
    render_message(e.message, :not_found)
  end

  private

  def sign_in_params
    params
      .require(:user)
      .permit(
        :email,
        :password
      )
  end
end
