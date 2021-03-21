require 'swagger_helper'

describe 'Sessions' do
  path '/api/v1/users/sign_in' do
    post 'Creates a user session' do
      tags 'Session'
      consumes 'application/json'
      parameter name: :params, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              email: { type: :string, example: 'hulk@dev.com' },
              password: { type: :string, example: 'password' }
            },
            required: %w[email password]
          }
        }
      }

      response '201', 'Valid Credentials' do
        before { create :user }
        let!(:params) { { user: { email: User.first.email, password: 'password' } } }
        run_test!
      end

      response '422', 'Invalid Credentials' do
        before { create :user }
        let!(:params) { { user: { email: User.first.email, password: 'one' } } }
        run_test!
      end

      response '404', 'User Not found' do
        let!(:params) { { user: { email: 'one@one.com', password: 'one' } } }
        run_test!
      end
    end
  end
end
