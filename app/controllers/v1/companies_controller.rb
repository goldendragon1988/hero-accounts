class V1::CompaniesController < ApiController

  before_action :set_company, except: [:index, :create]

  def index
    render_success Company.all, 200, each_serializer: V1::CompanySerializer
  end

  def show
    render_success(@company, 200, serializer: V1::CompanySerializer)
  end

  def create
    company = Company.new(company_params)

    if company.save
      render_success(company, 201, erializer: V1::CompanySerializer)
    else
      render_errors(company, 422)
    end
  end

  def update
    if @company.update(company_params)
      render_success(@company, serializer: V1::CompanySerializer)
    else
      render_errors(@company)
    end
  end

  def destroy
    render_message("Successfully destroy a company") if @company.destroy
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def company_params
    params
      .require(:company)
      .permit(:name, :company_id)
  end
end
