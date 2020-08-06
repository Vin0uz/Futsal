require "rails_helper"

describe Api::TeamsController do
  describe "#index" do
    it "returns json list of all teams" do
      create(:team, name: "Michel", acronym: "MICH")
      create(:team, name: "Didier", acronym: "DID")

      get(:index)

      expect(response.body).to eq(Team.all.to_json)
    end
  end
end
