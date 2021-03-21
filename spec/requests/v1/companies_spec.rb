require 'swagger_helper'

RSpec.describe 'Companies API' do
  path '/api/v1/companies' do
    post 'Creates a company' do
      tags 'Companies'
      security [{ bearer_auth: [] }]
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          company: {
            type: :object,
            properties: {
              name: { type: :string },
            },
            required: [ 'name']
          }
        }
      }

      response '201', 'company created' do
        let(:auth) { authorize_user }
        let(:Authorization) { auth[:token] }
        let(:params) { { company: { name: 'foo' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:auth) { authorize_user }
        let(:Authorization) { auth[:token] }
        let(:params) { { company: { name: nil } } }
        run_test!
      end
    end
  end
end
