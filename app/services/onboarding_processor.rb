class OnboardingProcessor < BaseProcessor
  attr_reader :user, :params

  def initialize(user, params)
    super(user)
    @params = params
  end

  def onboard!
    add_user_permission
  end

  private

  def add_user_permission
    Permission.create!(
      user: user.me,
      role: role,
      active: true
    )
  end

  def role
    Role.find_by(name: params[:name])
  end

end
