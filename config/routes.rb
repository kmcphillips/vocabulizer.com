Vocabulizer::Application.routes.draw do

  devise_for :users

  root :to => "home#index"

  resources :learn, only: [:show]

  resources :terms, only: [:index, :show, :new, :edit, :create, :update]
  
end
