class CreatePlayers < ActiveRecord::Migration[6.0]
  def change
    create_table :players, id: :uuid do |t|
      t.references :team, foreign_key: true, index: true, type: :uuid
      t.string :name
      t.timestamps
    end
  end
end
