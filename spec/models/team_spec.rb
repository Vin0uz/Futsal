require "rails_helper"

describe Team do
  it { should have_many(:players) }
  it { should have_many(:team_games) }
  it { should have_many(:games).through(:team_games) }
end
