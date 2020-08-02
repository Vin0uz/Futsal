class AddGoalsToTeamGame < ActiveRecord::Migration[6.0]
  def change
    add_column :team_games, :goals_scored, :integer, default: 0, null: false
    add_column :team_games, :goals_conceded, :integer, default: 0, null: false
  end
end
