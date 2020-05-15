module Api
  class ChartsController < ApplicationController
    def action_type_goals
      render json: {
        labels: Goal.all.pluck(:action_type).uniq,
        data: Goal.group(:action_type).count,
      }
    end

    def team_goals
      render json: {
        labels: Team.all.pluck(:acronym).uniq,
        data: Goal.joins(scorer: :team).group("teams.acronym").count,
      }
    end
  end
end
