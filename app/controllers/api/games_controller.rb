module Api
  class GamesController < ApplicationController
    def match_weeks
      match_weeks = Game.all.pluck(:match_week).uniq
      render json: match_weeks
    end
  end
end
