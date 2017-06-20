Rails.application.routes.draw do

  root 'admin/products#index'

  devise_for :users
  namespace :admin do
    resources :products
    resources :brands
    resources :categories
  end

  # scope module: 'admin', path: 'admin' do
  #   resources :products
  #   resources :brands
  #   resources :categoriess
  # end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
