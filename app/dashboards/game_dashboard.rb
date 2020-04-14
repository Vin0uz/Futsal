require "administrate/base_dashboard"

class GameDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    goals: Field::HasMany,
    home_team: Field::BelongsTo.with_options(class_name: "Team"),
    away_team: Field::BelongsTo.with_options(class_name: "Team"),
    id: Field::String.with_options(searchable: false),
    matchweek: Field::String,
    date: Field::DateTime,
    home_team_id: Field::String.with_options(searchable: false),
    away_team_id: Field::String.with_options(searchable: false),
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    "goals",
    "home_team",
    "away_team",
    "id",
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    "goals",
    "home_team",
    "away_team",
    "id",
    "matchweek",
    "date",
    "home_team_id",
    "away_team_id",
    "created_at",
    "updated_at",
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    "goals",
    "home_team",
    "away_team",
    "matchweek",
    "date",
    "home_team_id",
    "away_team_id",
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how games are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(game)
  #   "Game ##{game.id}"
  # end
end
