module Api
  class ChartsController < ApplicationController
    def action_type_goals
      hash_data = Goal.group(:action_type).count
      labels = Goal.all.pluck(:action_type).uniq
      data = labels.map { |label| (hash_data[label] || 0) }

      render json: { labels: labels, data: data }
    end

    def team_goals
      hash_data = Goal.joins(scorer: :team).group("teams.acronym").count
      labels = Team.all.pluck(:acronym).uniq
      data = labels.map { |label| (hash_data[label] || 0) }

      render json: {
        labels: labels,
        data: data,
      }
    end
  end
end
