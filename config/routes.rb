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
    get "/goal_action_type_teams", to: "charts#goal_action_type_teams"
    get "/goal_action_type_match_weeks", to: "charts#goal_action_type_match_weeks"
    get "/teams", to: "teams#index"
    get "/players", to: "players#index"
    get "/goals/action_types", to: "goals#action_types"
    get "/games/match_weeks", to: "games#match_weeks"
  end
end
