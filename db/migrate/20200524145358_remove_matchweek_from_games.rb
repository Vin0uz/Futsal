class RemoveMatchweekFromGames < ActiveRecord::Migration[6.0]
  def change
    remove_column :games, :matchweek
  end
end
