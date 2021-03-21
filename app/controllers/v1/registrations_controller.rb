class V1::RegistrationsController < Devise::RegistrationsController
  include ResponseConcern

  respond_to :json

  def create
    user = User.new(user_params)
    if user.save
      render_success({ token: user.generate_jwt }, 201)
    else
      render_errors(user, 422)
    end
  end

  private

  def user_params
    params
      .require(:user)
      .permit(
        :email,
        :first_name,
        :last_name,
        :password
      )
  end
end
