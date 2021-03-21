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


  path '/api/v1/companies' do
    get 'Retrieves companies' do
      tags 'Companies'
      security [{ bearer_auth: [] }]
      produces 'application/json'

      response '200', 'companies found' do
        let(:auth) { authorize_user }
        let(:Authorization) { auth[:token] }
        let(:dummy) { Company.create(name: "test") }
        run_test!
      end
    end
  end

  path '/api/v1/companies/{id}' do
    get 'Retrieves a company' do
      tags 'Companies'
      security [{ bearer_auth: [] }]
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'company found' do
        schema type: :object,
          properties: {
            company: {
              type: :object,
              properties: {
                name: { type: :string },
              },
              required: [ 'name']
            }
          }

        let(:auth) { authorize_user }
        let(:Authorization) { auth[:token] }
        let(:id) { Company.create(name: 'foo').id }
        run_test!
      end
    end
  end

  path '/api/v1/companies/{id}' do
    put 'Updates a company' do
      tags 'Companies'
      security [{ bearer_auth: [] }]
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
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
        let(:id) { Company.create(name: 'test').id }
        let(:params) { { company: { name: 'foo' } } }
        run_test!
      end

      response '422', 'invalid request' do
        let(:auth) { authorize_user }
        let(:Authorization) { auth[:token] }
        let(:id) { Company.create(name: 'test').id }
        let(:params) { { company: { name: nil } } }
        run_test!
      end
    end
  end

  path '/api/v1/companies/{id}' do
    delete 'Destroy a company' do
      tags 'Companies'
      security [{ bearer_auth: [] }]
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'Company destroy' do
        let(:auth) { authorize_user }
        let(:Authorization) { auth[:token] }
        let(:dummy) { create :company }
        let(:id) { dummy.id }
        run_test!
      end
    end
  end
end
