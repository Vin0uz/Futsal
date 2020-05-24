require "rails_helper"

describe Game do
  it { should have_many(:goals) }
  it { should have_many(:team_games) }
  it { should have_many(:teams).through(:team_games) }

  it "applies a default scope to order by match_weeks" do
    expect(Game.all.to_sql).to eq Game.all.order(match_week: :asc).to_sql
  end
end
