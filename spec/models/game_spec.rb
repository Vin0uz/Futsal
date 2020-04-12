require "rails_helper"

describe Game do
  it { should have_many(:goals) }
  it { should belong_to(:home_team) }
  it { should belong_to(:away_team) }
end
