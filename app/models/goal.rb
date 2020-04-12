class Goal < ApplicationRecord
  belongs_to :scorer, class_name: "Player"
  belongs_to :passer, class_name: "Player", optional: true
  belongs_to :game
end
