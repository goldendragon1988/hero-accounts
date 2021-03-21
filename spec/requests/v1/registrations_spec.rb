require 'swagger_helper'

RSpec.describe 'Registrations' do
  path '/api/v1/users' do
    post 'Creates a user' do
      tags 'Registration'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string },
              first_name: { type: :string },
              last_name: { type: :string },
              password: { type: :string }
            },
            required: [
              :email,
              :first_name,
              :last_name,
              :password
            ]
          }
        }
      }

      response '201', 'User created' do
        let(:params) { { user: attributes_for(:user) } }
        run_test!
      end

      response '422', 'Invalid Credentials' do
        let!(:params) { { user: { email: 'none@none' } } }
        run_test!
      end
    end
  end

  path '/api/v1/user/onboard' do
    put 'Creates a user role' do
      tags 'Registration'
      security [{ bearer_auth: [] }]
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          role: {
            type: :object,
            properties: {
              name: { type: :string, enum: %w[recruiter candidate] }
            },
            required: [
              :name,
            ]
          }
        }
      }

      response '200', 'Role created' do
        before { create :role, :recruiter }
        let(:auth) { authorize_user }
        let(:Authorization) { auth[:token] }
        let(:params) { { role: { name: "recruiter" } } }
        run_test!
      end
    end
  end
end
