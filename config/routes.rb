Rails.application.routes.draw do
  root 'home#index'

  resources :lists do
    resources :items
  end

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
