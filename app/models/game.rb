class Game < ApplicationRecord
  has_many :goals
  has_many :team_games
  has_many :teams, through: :team_games
end
