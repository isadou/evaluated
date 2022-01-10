Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :moves do
    member do
      get :add_rooms
      post :create_rooms
      get :rooms_list
      get :recap
      get :details
      get :find_mover
    end
    resources :rooms do
      member do
        get "/add_stuffs", to: "moves#add_stuffs"
        post "/create_stuffs", to: "moves#create_stuffs"
        get "/room_destroy", to: "moves#room_destroy"
        post "/room_destroy", to: "moves#room_destroy"
      end
    end
  end
end
