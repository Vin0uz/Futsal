class ChangeDefaultResultOnTeamGames < ActiveRecord::Migration[6.0]
  def change
    change_column_default :team_games, :result, from: "draw", to: "unknown"
  end
end
