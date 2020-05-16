module Api
  class ChartsController < ApplicationController
    def action_type_goals
      data = add_filters_to_query(Goal.with_joins).group(:action_type).count
      labels = add_filters_to_query(Goal.with_joins).all.pluck(:action_type).uniq

      render json: { labels: labels, data: data }
    end

    def team_goals
      data = add_filters_to_query(Goal.with_joins).group("teams.acronym").count
      labels = add_filters_to_query(Team.joins(:home_games, :away_games, players: :goals)).all.pluck(:acronym).uniq

      render json: { labels: labels, data: data }
    end

    private

    def add_filters_to_query(query)
      if team = params[:team].presence
        query = query.where(teams: {acronym: team})
      end

      if action_type = params[:action_type].presence
        query = query.where(goals: {action_type: action_type})
      end

      if matchweek = params[:matchweek].presence
        query = query.where(games: {matchweek: matchweek})
      end

      query
    end
  end
end
