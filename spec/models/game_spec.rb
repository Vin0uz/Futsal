require "rails_helper"

describe Game do
  it { should have_many(:goals) }
  it { should have_many(:team_games) }
  it { should have_many(:teams).through(:team_games) }
  it { should belong_to(:home_team) }
  it { should belong_to(:away_team) }
end
