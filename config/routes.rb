#require 'api_contraints.rb'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new('v1', true) do
      resources :posts, except: [:new, :edit]
      # resources :users, only: [:create]

      post '/signup', to: 'users#create'
    end
  end

  post '/auth/login', to: 'authentication#authenticate'
  # post '/signup', to: 'users#create'
end
