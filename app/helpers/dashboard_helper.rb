module DashboardHelper
  def team_ranking(team:, ranking:)
    (ranking.keys.index(team.acronym.to_sym) + 1).ordinalize
  end

  def team_ranking_attack(team:, ranking:)
    attack_ranking = ranking.sort_by { |_team, details| details[:goals_for] }.reverse.to_h
    (attack_ranking.keys.index(team.acronym) + 1).ordinalize
  end

  def team_ranking_defense(team:, ranking:)
    defense_ranking = ranking.sort_by { |_team, details| details[:goals_against] }.to_h
    (defense_ranking.keys.index(team.acronym) + 1).ordinalize
  end

  def last_results(team:)
    team.games.last(5)
  end

  def last_game_scoreboard(team:)
    game = team.games.where("date < ?", Date.current).order(match_week: :desc).first
    if game.present?
      team_game_home = game.team_games.find_by(home: true)
      team_game_away = game.team_games.find_by(home: false)
      "#{team_game_home.team.acronym} #{team_game_home.goals_scored} - #{team_game_away.goals_scored} #{team_game_away.team.acronym}"
    else
      " - "
    end
  end

  def class_in_ranking(index:)
    css_class = ""
    case index
    when 10..11
      css_class = "bg-red-200"
    when 0
      css_class = "bg-green-200"
    end
    css_class
  end
end
