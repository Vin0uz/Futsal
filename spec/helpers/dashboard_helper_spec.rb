require "rails_helper"

describe DashboardHelper do
  describe "#team_ranking" do
    it "returns proper index of team in ranking" do
      nmf = create(:team, acronym: "NMF", name: "Nantes Metropole Futsal")
      toulon = create(:team, acronym: "Toulon", name: "Toulon Elite Futsal")

      ranking = {
        "NMF": {
          name: "Nantes Metropole Futsal",
          games: 3,
          points: 7,
          goals_for: 12,
          goals_against: 2,
          goal_average: 10,
        },
        "Toulon": {
          name: "Toulon Elite Futsal",
          games: 3,
          points: 1,
          goals_for: 2,
          goals_against: 12,
          goal_average: -10,
        },
      }

      expect(team_ranking(team: nmf, ranking: ranking)).to eq("1er")
      expect(team_ranking(team: toulon, ranking: ranking)).to eq("2ème")
    end
  end
end
