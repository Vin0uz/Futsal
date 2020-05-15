FactoryBot.define do
  factory :game do
    association :home_team, factory: :team
    association :away_team, factory: :team
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
end
