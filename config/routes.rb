Treebook::Application.routes.draw do
  get "profiles/show"

  as :user do
    get '/register', to: 'devise/registrations#new', as: :register
    get '/login', to: 'devise/sessions#new', as: :login
    get '/logout', to: 'devise/sessions#destroy', as: :logout
  end

  devise_for :users, skip: [:sessions]

  as :user do
    get "/login" => "devise/sessions#new", as: :new_user_session
    post "/login" => "devise/sessions#create", as: :user_session
    delete "/logout" => "devise/sessions#destroy", as: :destroy_user_session
  end


  resources :statuses
  get 'feed', to: 'statuses#index', as: :feed
  get '/:id', to: 'profiles#show', as: "profile"

  resources :user_friendships

  
  root to: 'statuses#index'


end
