class AddResultToTeamGame < ActiveRecord::Migration[6.0]
  def change
    add_column :team_games, :result, :string
  end
end
