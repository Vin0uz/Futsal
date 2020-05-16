require "rails_helper"

describe Api::GamesController do
  describe "#matchweeks" do
    it "returns array of uniq matchweeks values" do
      create(:game, matchweek: "Day 1")
      get(:matchweeks)

      parsed_body = JSON.parse(response.body)

      expect(parsed_body).to eq(["Day 1"])
    end
  end
end
