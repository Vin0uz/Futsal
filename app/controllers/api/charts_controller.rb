module Api
  class ChartsController < ApplicationController
    def action_type_goals
      data = Goal.group(:action_type).count
      labels = Goal.all.pluck(:action_type).uniq

      render json: { labels: labels, data: data }
    end

    def team_goals
      data = Goal.joins(scorer: :team).group("teams.acronym").count
      labels = Team.all.pluck(:acronym).uniq

      render json: { labels: labels, data: data }
    end
  end
end
