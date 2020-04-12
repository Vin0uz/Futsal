class CreateGoals < ActiveRecord::Migration[6.0]
  def change
    create_table :goals, id: :uuid do |t|
      t.references :scorer, index: true, type: :uuid
      t.references :passer, index: true, type: :uuid
      t.references :game, foreign_key: true, index: true, type: :uuid
      t.string :action_type
      t.timestamps
    end
  end
end
