module Api
  class GoalsController < ApplicationController
    def action_types
      action_types = Goal.all.pluck(:action_type).uniq
      render json: action_types
    end

    def videos
      goals = add_filters_to_query(Goal.with_joins).select("games.match_week, teams.acronym, players.name, goals.action_type, goals.youtube_id").as_json
      render json: goals
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
