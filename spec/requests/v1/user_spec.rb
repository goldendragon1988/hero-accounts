require 'swagger_helper'

RSpec.describe 'User' do
  path '/api/v1/user/add_company' do
    put 'Add Company to user' do
      tags 'Companies'
      security [{ bearer_auth: [] }]
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          company_id: { type: :number }
        }
      }

      response '201', 'Company created' do
        let(:auth) { authorize_user }
        let(:Authorization) { auth[:token] }
        let(:company) { create :company }
        let(:params) { { company_id: company.id } }
        run_test!
      end
    end
  end
end
