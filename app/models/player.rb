class Player < ApplicationRecord
  belongs_to :team
  has_many :goals, class_name: "Goal", foreign_key: "scorer_id"
  has_many :assists, class_name: "Goal", foreign_key: "passer_id"
end
