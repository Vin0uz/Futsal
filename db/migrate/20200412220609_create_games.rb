class CreateGames < ActiveRecord::Migration[6.0]
  def change
    create_table :games, id: :uuid do |t|
      t.string :matchweek
      t.datetime :date
      t.references :home_team, index: true, type: :uuid
      t.references :away_team, index: true, type: :uuid
      t.timestamps
    end
  end
end
