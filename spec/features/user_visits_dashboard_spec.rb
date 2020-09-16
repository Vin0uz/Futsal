require "rails_helper"

feature "User visits the dashboard page" do
  scenario "sees all tags elements" do
    team = create(:team, name: "MyTeam", acronym: "FC MY")
    opponent = create(:team, name: "Opponent", acronym: "FC Oppo")
    game = create(:game, date: DateTime.tomorrow)
    create(:team_game, game: game, team: team, result: "win")
    create(:team_game, game: game, team: opponent, result: "loss")

    visit root_path

    within ".next_opponent" do
      within ".tags" do
        expect(page).to have_content("1er V 2ème Attaque 1er Défense")
      end
    end
  end
end
