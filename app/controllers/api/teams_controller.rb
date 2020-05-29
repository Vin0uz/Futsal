module Api
  class TeamsController < ApplicationController
    def index
      teams = add_filters_to_query(Team.left_joins(:games, players: :goals)).all.uniq
      render json: teams
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
