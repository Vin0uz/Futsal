class Team < ApplicationRecord
  has_many :players
  has_many :team_games
  has_many :games, through: :team_games

  def total_points
    (team_games.where(result: "win").count * 3) + (team_games.where(result: "draw").count)
  end

  def total_goals_for
    team_games.sum(:goals_scored)
  end

  def total_goals_against
    team_games.sum(:goals_conceded)
  end

  def goal_average
    total_goals_for - total_goals_against
  end

  def ranking_details
    details = {}
    details[:name] = name
    details[:games] = games.count
    details[:points] = total_points
    details[:goals_for] = total_goals_for
    details[:goals_against] = total_goals_against
    details[:goal_average] = goal_average
    details
  end
end
