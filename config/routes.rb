Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :moves do
    member do
      get :add_room
    end
    resources :rooms do
      member do
       get "/add_stuff", to: "moves#add_stuff"
      end
    end
  end
end
