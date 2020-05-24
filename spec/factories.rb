FactoryBot.define do
  factory :game do
  end

  factory :goal do
    association :scorer, factory: :player
    game
  end

  factory :player do
    team
  end

  factory :team do
  end

  factory :team_game do
    team
    game
  end
end
