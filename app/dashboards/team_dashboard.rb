require "administrate/base_dashboard"

class TeamDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    players: Field::HasMany,
    games: Field::HasMany,
    id: Field::String.with_options(searchable: false),
    name: Field::String,
    acronym: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :name,
    :acronym,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :acronym,
    :players,
    :games,
    :id,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :name,
    :acronym,
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(team)
    team.acronym
  end
end
