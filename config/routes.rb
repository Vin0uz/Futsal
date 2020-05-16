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
    get "/teams", to: "teams#index"
    get "/goals/action_types", to: "goals#action_types"
    get "/games/matchweeks", to: "games#matchweeks"
  end
end
