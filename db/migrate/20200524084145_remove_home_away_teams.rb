class RemoveHomeAwayTeams < ActiveRecord::Migration[6.0]
  def change
    remove_reference :games, :home_team
    remove_reference :games, :away_team
  end
end
