require "administrate/base_dashboard"

class PlayerDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    team: Field::BelongsTo,
    goals: Field::HasMany,
    assists: Field::HasMany.with_options(class_name: "Goal"),
    id: Field::String.with_options(searchable: false),
    name: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :name,
    :team,
    :goals,
    :assists,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :name,
    :team,
    :goals,
    :assists,
    :id,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :team,
    :name,
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(player)
    player.name + "(#{player.team.acronym})"
  end
end
