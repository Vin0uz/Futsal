require "rails_helper"

describe Api::GoalsController  do
  describe "#action_types" do
    it "returns array of all uniq action type values" do
      create(:goal, action_type: "NiceOne")
      get(:action_types)

      parsed_body = JSON.parse(response.body)

      expect(parsed_body).to eq(["NiceOne"])
    end
  end
end
