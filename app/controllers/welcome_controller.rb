class WelcomeController < ApplicationController
  def home
    games = Game.all.pluck(:matchweek).uniq
    action_types = Goal.all.pluck(:action_type).uniq
    teams = Team.all.pluck(:acronym).uniq
    @chart1 = build_chart_data(labels: games, attributes: action_types, type: "goals_action_matchweek")
    @chart2 = build_chart_data(labels: teams, attributes: action_types, type: "goals_action_team")
  end

  private

  def build_chart_data(labels:, attributes:, type:)
    chart_data = {labels: labels, attributes: attributes, data: nil}

    if type == "goals_action_matchweek"
      query_results = Goal.joins(:game).group("games.matchweek", "goals.action_type").count
    elsif type == "goals_action_team"
      query_results = Goal.joins(scorer: :team).group("teams.acronym", "goals.action_type").count
    end

    formatted_response = transform_query_group(query_results)

    chart_data[:data] = []
    attributes.each do |attribute|
      attribute_arr = []
      labels.each do |label|
        attribute_arr << (formatted_response.dig(label, attribute) || 0)
      end
      chart_data[:data] << attribute_arr
    end
    chart_data
  end

  def transform_query_group(results)
    formatted_result = {}
    results.each do |(key, key2), quantity|
      formatted_result[key] ||= {}
      formatted_result[key][key2] = quantity
    end
    formatted_result
  end
end
