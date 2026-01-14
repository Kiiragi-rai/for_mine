Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # lineログインの準備ができたらONに、
  # devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  authenticated :user do
    root to: "home_pages#index", as: :user_root
  end
  
  # ログイン前のルートページ
  unauthenticated do
    root to: "top_pages#top"
  end

# LINE ログインの準備ができたらOFFに
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  devise_scope :user do
    delete "logout", to: "devise/sessions#destroy", as: :logout
  end
  # devise_for :users, controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations'
  #   # root: 'top_pages#index'
  # }
  Rails.logger.info "===== ROUTES FILE LOADED ====="

  resources :anniversaries, only: %i[index show new create edit update destroy]
  # has_oneなのでresorce
  resource :partner 

  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  
  # Defines the root path route ("/")
  # root "posts#index"
end
