module Api
  class GoalsController < ApplicationController
    def action_types
      action_types = Goal.all.pluck(:action_type).uniq
      render json: action_types
    end
  end
end
