class AddResultToTeamGame < ActiveRecord::Migration[6.0]
  def change
    add_column :team_games, :result, :string, default: "draw", null: false
  end
end
