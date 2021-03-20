Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  scope :api, defaults: { format: :json } do
    namespace :v1 do
      devise_for :users, controllers: {
        sessions: 'v1/sessions',
        registrations: 'v1/registrations',
      }

      resources :companies
    end
  end
  root to: "home#ping"
end
