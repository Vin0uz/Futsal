class AddYoutubeIdToGoal < ActiveRecord::Migration[6.0]
  def change
    add_column :goals, :youtube_id, :string
  end
end
