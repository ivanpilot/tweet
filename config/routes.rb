#require 'api_contraints.rb'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: 'json'} do
    # scope module: :v2, constraints: ApiConstraints.new('v2') do
    #   resources :posts, only: [:index]
    # end

    scope module: :v1, constraints: ApiConstraints.new('v1', true) do
      resources :posts, except: [:new, :edit] do
        resources :comments, only: [:index, :create, :show, :update]
      end
    end
  end

  post '/auth/login', to: 'authentication#authenticate'
  post '/signup', to: 'users#create'
end
