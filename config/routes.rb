Rails.application.routes.draw do
  resources :lists do
    resources :tasks, only: [:edit, :new, :destroy]
  end

  root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
