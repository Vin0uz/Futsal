require "administrate/base_dashboard"

class GameDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    goals: Field::HasMany,
    teams: Field::HasMany,
    match_week: Field::Number.with_options(searchable: true),
    date: Field::DateTime,
    display_game: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :display_game,
    :goals,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :display_game,
    :teams,
    :date,
    :goals,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :goals,
    :match_week,
    :date,
  ].freeze

  COLLECTION_FILTERS = {}.frezee

  def display_resource(game)
    "J#{game.match_week}: #{game.teams.first.acronym} - #{game.teams.second.acronym}"
  end
end
