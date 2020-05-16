require "rails_helper"

describe Api::TeamsController do
  describe "#index" do
    it "returns json list of all teams" do
      create(:team, name: "Michel", acronym: "MICH")
      create(:team, name: "Didier", acronym: "DID")

      get(:index)

      parsed_body = JSON.parse(response.body)

      expect(parsed_body).to eq(Team.all.as_json)
    end
  end
end
