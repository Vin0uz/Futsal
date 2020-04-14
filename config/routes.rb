Rails.application.routes.draw do
  namespace :admin do
    resources :goals
    resources :players
    resources :teams
    resources :games

    root to: "goals#index"
  end

  root "home#show"
end
