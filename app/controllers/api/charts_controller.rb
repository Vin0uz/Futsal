module Api
  class ChartsController < ApplicationController
    def action_type_goals
      data = add_filters_to_query(Goal.with_joins).group(:action_type).count
      labels = add_filters_to_query(Goal.with_joins).all.pluck(:action_type).uniq

      render json: { labels: labels, data: data }
    end

    def team_goals
      data = add_filters_to_query(Goal.with_joins).group("teams.acronym").count
      labels = add_filters_to_query(Team.left_joins(:games, players: :goals)).all.pluck(:acronym).uniq

      render json: { labels: labels, data: data }
    end

    def goal_action_type_teams
      labels = add_filters_to_query(Team.left_joins(:games, players: :goals)).all.pluck(:acronym).uniq
      labels2 = add_filters_to_query(Goal.with_joins).all.pluck(:action_type).uniq
      grouped_result = add_filters_to_query(Goal.with_joins).group("teams.acronym", "goals.action_type").count

      data = unlink_labels(grouped_result, labels, labels2)
      render json: { labels: labels, data: data }
    end

    def goal_action_type_match_weeks
      labels = add_filters_to_query(Game.left_joins(:teams, :goals)).all.pluck(:match_week).uniq
      labels2 = add_filters_to_query(Goal.with_joins).all.pluck(:action_type).uniq
      grouped_result = add_filters_to_query(Goal.with_joins).group("games.match_week", "goals.action_type").count

      data = unlink_labels(grouped_result, labels, labels2)
      render json: { labels: labels, data: data }
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

    def unlink_labels(data, labels, labels2)
      result = {}
      labels2.each do |label2|
        label_array = []
        labels.each do |label|
          label_array << (data[[label, label2]] || 0)
        end
        result[label2] = label_array
      end
      result
    end
  end
end
