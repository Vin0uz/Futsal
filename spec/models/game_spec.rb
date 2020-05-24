require "rails_helper"

describe Game do
  it { should have_many(:goals) }
  it { should have_many(:team_games) }
  it { should have_many(:teams).through(:team_games) }
end
