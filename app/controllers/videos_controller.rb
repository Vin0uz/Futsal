class VideosController < ApplicationController
  def index
    @cards_data = build_cards_data
  end

  private

  def build_cards_data
    {
      games_count: Game.count,
      best_attack: Goal.joins(scorer: :team).group("teams.acronym").order("count_id desc").count(:id).first,
      best_scorer: Goal.joins(:scorer).group("players.name").order("count_id desc").count(:id).first,
    }
  end
end
