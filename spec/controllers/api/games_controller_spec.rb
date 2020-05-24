require "rails_helper"

describe Api::GamesController do
  describe "#match_weeks" do
    it "returns array of uniq matchweeks values" do
      create(:game, match_week: 123)
      get(:match_weeks)

      parsed_body = JSON.parse(response.body)

      expect(parsed_body).to eq([123])
    end
  end
end
