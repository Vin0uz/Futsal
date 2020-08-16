class HomeController < ApplicationController
  def show
    @team = Team.find_by(acronym: "NMF")
    @last_team_games = @team.team_games.joins(:game).order(created_at: :desc).first(5)
    @ranking = ranking
  end


  private

  def ranking
    rank = {}
    Team.all.find_each do |team|
      rank[team.acronym] = team.ranking_details
    end
    rank.sort_by{|team, details| [details[:points], details[:goal_average]] }.reverse.to_h
  end
end
