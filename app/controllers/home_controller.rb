class HomeController < ApplicationController
  def show
    @team = Team.last
    @next_opponent = @team.next_opponent
    @ranking = ranking
  end

  private

  def ranking
    rank = {}
    Team.all.find_each do |team|
      rank[team.acronym.to_sym] = team.ranking_details
    end
    rank.sort_by { |_team, details| [details[:points], details[:goal_average]] }.reverse.to_h
  end
end
