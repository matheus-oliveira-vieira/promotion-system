Rails.application.routes.draw do
  root "home#index"
  
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :promotions, only: %i[index new create show edit update] do
    member do
      post 'generate_coupons'
      post 'approve'
      
    end
  end
  get 'search', to:"promotions#search"

  resources :coupons, only: [] do
    post 'inactivate', on: :member
  end
end
