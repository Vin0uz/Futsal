class AddIntegerMatchWeekOnGame < ActiveRecord::Migration[6.0]
  def change
    add_column :games, :match_week, :bigint
  end
end
