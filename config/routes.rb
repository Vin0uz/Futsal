Rails.application.routes.draw do
  namespace :admin do
    resources :goals
    resources :players
    resources :teams
    resources :games

    root to: "goals#index"
  end

  root "teams#index"

  resources :teams, only: :index

  namespace :api do
    get "/action_type_goals", to: "charts#action_type_goals"
    get "/team_goals", to: "charts#team_goals"
  end
end
