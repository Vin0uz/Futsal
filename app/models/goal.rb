class Goal < ApplicationRecord
  belongs_to :scorer, class_name: "Player"
  belongs_to :passer, class_name: "Player", optional: true
  belongs_to :game
  belongs_to :team

  def self.with_joins
    left_joins(:game, scorer: :team)
  end
end
