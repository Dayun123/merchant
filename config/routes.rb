Rails.application.routes.draw do

  get '/shop' => 'storefront#index'

  get '/about' => 'storefront#about'

  root 'storefront#index'

  devise_for :users
  namespace :admin do
    resources :products
    resources :brands
    resources :categories
  end

  resource :cart, only: [:edit, :update, :destroy]

  resources :line_items, only: [:create, :destroy ]

  # scope module: 'admin', path: 'admin' do
  #   resources :products
  #   resources :brands
  #   resources :categoriess
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
