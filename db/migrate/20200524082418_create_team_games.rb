class CreateTeamGames < ActiveRecord::Migration[6.0]
  def change
    create_table :team_games, id: :uuid do |t|
      t.references :team, foreign_key: true, index: true, type: :uuid
      t.references :game, foreign_key: true, index: true, type: :uuid
      t.boolean :home
    end
  end
end
