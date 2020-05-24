class Game < ApplicationRecord
  has_many :goals
  has_many :team_games
  has_many :teams, through: :team_games

  default_scope { order(match_week: :asc) }
end
