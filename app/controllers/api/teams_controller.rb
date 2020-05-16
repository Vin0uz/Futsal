module Api
  class TeamsController < ApplicationController
    def index
      teams = Team.all
      render json: teams
    end
  end
end
