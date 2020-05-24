require "rails_helper"

describe TeamGame do
  it { should belong_to(:team) }
  it { should belong_to(:game) }
end
