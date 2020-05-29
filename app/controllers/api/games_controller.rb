module Api
  class GamesController < ApplicationController
    def match_weeks
      match_weeks = add_filters_to_query(Game.left_joins(:teams, :goals)).all.pluck(:match_week).uniq
      render json: match_weeks
    end

    private

    def add_filters_to_query(query)
      if (team = params[:team].presence)
        query = query.where(teams: { acronym: team })
      end

      if (action_type = params[:action_type].presence)
        query = query.where(goals: { action_type: action_type })
      end

      if (match_week = params[:match_week].presence)
        query = query.where(games: { match_week: match_week })
      end

      query
    end
  end
end
