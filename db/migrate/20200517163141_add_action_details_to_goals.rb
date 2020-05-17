class AddActionDetailsToGoals < ActiveRecord::Migration[6.0]
  def change
    add_column :goals, :action_details, :string
  end
end
