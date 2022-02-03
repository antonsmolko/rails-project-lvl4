# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'auth/:provider', to: 'web/auth#request', as: :auth_request
  get 'auth/:provider/callback', to: 'web/auth#callback', as: :callback_auth
  delete 'auth', to: 'web/auth#destroy', as: :sign_out

  scope module: :web do
    root 'home#index'
    get '/registration', to: 'registration#index', as: :new_user_registration
  end
end
