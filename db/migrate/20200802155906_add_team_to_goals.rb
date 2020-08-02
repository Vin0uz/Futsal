class AddTeamToGoals < ActiveRecord::Migration[6.0]
  def change
    add_reference :goals, :team, index: true, type: :uuid
  end
end
