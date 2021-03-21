class V1::UsersController < ApiController
  before_action :authenticate_user!

  def show
    render_forbidden unless current_user
  end

  def onboard
    @processor = OnboardingProcessor.new(current_user, role_params)
    if @processor.onboard!
      render_message("Successfully onboard a user")
    else
      render_errors(@processor)
    end
  end

  def add_company
    @company = Company.find(params[:company_id])
    if @company && current_user.companies << @company
      render_message("Successfully add a recruiter to company", 201)
    else
      render_message("Error in adding a recruiter")
    end
  end

  private

  def role_params
    params
      .require(:role)
      .permit(:name)
  end
end
