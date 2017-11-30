Rails.application.routes.draw do
  resources :products, only: [:index]
  get '/products/:week', to: 'products#specific_week', as: 'specific_week'
  resources :orders, only: [:index, :destroy]
  resource :cart, only: [:show]
  resources :order_items, only: [:create, :update, :destroy, :save_order], defaults: { format: 'js' }
  get '/order_items/save_order/:id', to: 'order_items#save_order', as: 'save_order'
  get '/order_items/reset_order/:id', to: 'order_items#reset_order', as: 'reset_order'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'auth/facebook/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
end
