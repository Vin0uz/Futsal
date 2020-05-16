module Api
  class GamesController < ApplicationController
    def matchweeks
      matchweeks = Game.all.pluck(:matchweek).uniq
      render json: matchweeks
    end
  end
end
