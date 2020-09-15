require "administrate/base_dashboard"

class GameDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    goals: Field::HasMany,
    teams: Field::HasMany,
    id: Field::String,
    match_week: Field::Number,
    date: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :match_week,
    :teams,
    :goals,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :goals,
    :id,
    :match_week,
    :date,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :goals,
    :match_week,
    :date,
  ].freeze

  COLLECTION_FILTERS = {}.freeze
end
