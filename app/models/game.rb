class Game < ApplicationRecord
  has_many :goals
  has_many :team_games
  has_many :teams, through: :team_games

  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"
end
