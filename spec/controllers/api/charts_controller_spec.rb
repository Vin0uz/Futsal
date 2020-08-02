require "rails_helper"

describe Api::ChartsController do
  describe "#action_type_goals" do
    it "returns dataset with goals per action_type" do
      create(:goal, action_type: "attack")
      get(:action_type_goals)

      parsed_body = JSON.parse(response.body)

      expect(parsed_body["labels"]).to eq(["attack"])
      expect(parsed_body["data"]).to eq("attack" => 1)
    end
  end

  describe "#team_goals" do
    it "returns dataset with goals per team" do
      team1 = create(:team, acronym: "ZZ")
      team2 = create(:team, acronym: "team2")
      player = create(:player, team: team1)
      create(:goal, scorer: player, team: team1, game: create(:game, teams: [team1, team2]))

      get(:team_goals)

      parsed_body = JSON.parse(response.body)
      expect(parsed_body["labels"]).to eq(["ZZ", "team2"])
      expect(parsed_body["data"]).to eq("ZZ" => 1)
    end
  end

  describe "#goal_action_type_teams" do
    it "returns labels and data as hash of arrays" do
      team1 = create(:team, acronym: "ZZ")
      team2 = create(:team, acronym: "team2")
      player = create(:player, team: team1)
      create(:goal, action_type: "Nice", scorer: player, team: team1, game: create(:game, teams: [team1, team2]))

      get(:goal_action_type_teams)

      parsed_body = JSON.parse(response.body)
      expect(parsed_body["labels"]).to eq(["ZZ", "team2"])
      expect(parsed_body["data"]).to eq("Nice" => [1, 0])
    end
  end

  describe "#goal_action_type_match_weeks" do
    it "returns labels and data as hash of arrays" do
      team1 = create(:team, acronym: "ZZ")
      team2 = create(:team, acronym: "team2")
      player = create(:player, team: team1)
      create(:goal, action_type: "Nice", scorer: player, team: team1, game: create(:game, match_week: 123, teams: [team1, team2]))

      get(:goal_action_type_match_weeks)

      parsed_body = JSON.parse(response.body)
      expect(parsed_body["labels"]).to eq([123])
      expect(parsed_body["data"]).to eq("Nice" => [1])
    end
  end
end
