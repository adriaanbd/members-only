Rails.application.routes.draw do
  resources :posts, only: [:new, :create, :index]
  controller :sessions do 
    get 'login' => :new 
    post 'login' => :create 
    delete 'logout' => :destroy 
  end
  get 'signup' => 'users#new'
  get 'new' => 'posts#new'
  resources :users
  root to: 'posts#index'
end
