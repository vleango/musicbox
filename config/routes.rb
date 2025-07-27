Rails.application.routes.draw do
  root "home#index"

  resources :artists, only: [:index, :show]
  resources :searches, only: [] do
    collection do
      get :artist
    end
  end

  resources :artists, only: [:show] do
    member do
      get :songs
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check

end
