class Game < ApplicationRecord
  has_many :goals
  belongs_to :home_team, class_name: "Team"
  belongs_to :away_team, class_name: "Team"
end
