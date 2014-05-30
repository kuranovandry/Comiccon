Comiccon::Application.routes.draw do
  devise_for :admins
  devise_for :users

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount FullcalendarEngine::Engine => "/calendar"
  # root to: "devise#index"
  root to: redirect("/admin")

  get "white_list/index", as: "banned"

  resources :orders

  resources :line_items

  resources :carts

  resources :store

  resources :products do
    get :who_bought, on: :member
  end

  resources :events do 
    collection do 
      get :get_events
    end
    member do
      post :move
      post :resize
    end
  end
  
end
