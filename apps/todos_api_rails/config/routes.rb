Rails.application.routes.draw do
  # User routes
  resources :users, only: [:index, :show, :create, :update]

  # Session routes
  resource :session, only: [:create, :destroy]

  # Nested Orgs and projects routes
  resources :organizations do
    resources :projects, only: [:index, :create]
  end

  # Non nested Project Routes plus nested todos
  resources :projects, only: [:show, :update, :destroy] do
    resources :todos, only: [:index, :create]
    resources :project_memberships, only: [:index, :create, :update, :destroy]
  end

  # Non nested todos Routes
  resources :todos, only: [:show, :update, :destroy]


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
