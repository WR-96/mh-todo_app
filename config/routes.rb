Rails.application.routes.draw do
  resources :lists do
    resources :items
  end

  root 'home#index'
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
