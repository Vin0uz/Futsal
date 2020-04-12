class ActivatePgcryptoCreateTeams < ActiveRecord::Migration[6.0]
  def change
    enable_extension "pgcrypto"

    create_table :teams, id: :uuid do |t|
      t.string :name
      t.string :acronym
      t.timestamps
    end
  end
end
