module AuthHelper
  def authorize_user
    user = create(:user)

    {
      token: "Bearer #{user.generate_jwt}",
      user: user
    }
  end
end
