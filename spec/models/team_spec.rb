require "rails_helper"

describe Team do
  it { should have_many(:players) }
  it { should have_many(:home_games) }
  it { should have_many(:away_games) }
end
