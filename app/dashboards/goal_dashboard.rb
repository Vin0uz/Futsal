require "administrate/base_dashboard"

class GoalDashboard < Administrate::BaseDashboard
  ATTRIBUTE_TYPES = {
    scorer: Field::BelongsTo.with_options(class_name: "Player"),
    passer: Field::BelongsTo.with_options(class_name: "Player"),
    team: Field::BelongsTo,
    game: Field::BelongsTo,
    youtube_id: Field::String,
    id: Field::String.with_options(searchable: false),
    scorer_id: Field::String.with_options(searchable: false),
    passer_id: Field::String.with_options(searchable: false),
    action_type: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
  }.freeze

  COLLECTION_ATTRIBUTES = [
    :game,
    :scorer,
    :passer,
    :team,
  ].freeze

  SHOW_PAGE_ATTRIBUTES = [
    :game,
    :scorer,
    :passer,
    :action_type,
    :created_at,
    :updated_at,
  ].freeze

  FORM_ATTRIBUTES = [
    :scorer,
    :passer,
    :game,
    :team,
    :action_type,
    :youtube_id,
  ].freeze

  COLLECTION_FILTERS = {}.freeze

  def display_resource(goal)
    "#{goal.game.match_week} - #{goal.team.acronym} - #{goal.scorer.name}"
  end
end
