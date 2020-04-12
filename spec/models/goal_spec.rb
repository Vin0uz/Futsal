require "rails_helper"

describe Goal do
  it { should belong_to(:scorer) }
  it { should belong_to(:passer).optional }
  it { should belong_to(:game) }
end
