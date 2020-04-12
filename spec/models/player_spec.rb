require "rails_helper"

describe Player do
  it { should belong_to(:team) }
  it { should have_many(:goals) }
  it { should have_many(:assists) }
end
