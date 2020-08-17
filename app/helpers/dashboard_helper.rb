module DashboardHelper
  def team_ranking(team:, ranking:)
    ranking.keys.index(team.acronym)
  end

  def last_results(team:)
    team.games.last(5)
  end

  def last_game_scoreboard(team:)
    game = team.games.where("date < ?", DateTime.current).order(match_week: :desc).first
    if game.present?
      team_game_home = game.team_games.find_by(home: true)
      team_game_away = game.team_games.find_by(home: false)
      "#{team_game_home.team.acronym} #{team_game_home.goals_scored} - #{team_game_away.goals_scored} #{team_game_away.team.acronym}"
    else
      " - "
    end
  end

  def class_in_ranking(team:, index:)
    css_class = ""
    case index
    when 10..11
      css_class = "bg-red-200"
    when 0
      css_class="bg-green-200"
    end
    css_class
  end
end
