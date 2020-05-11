class TeamsController < ApplicationController
  def index
    games = Game.all.pluck(:matchweek).uniq
    action_types = Goal.all.pluck(:action_type).uniq
    teams = Team.all.pluck(:acronym).uniq
    @chart1 = build_chart_data(labels: games, attributes: action_types, type: "goals_action_matchweek")
    @chart2 = build_chart_data(labels: teams, attributes: action_types, type: "goals_action_team")
    @pie_chart1 = build_chart_data(labels: teams, attributes: action_types, type: "pie_team_goals")
    @pie_chart2 = build_chart_data(labels: action_types, attributes: teams, type: "pie_action_goals")
    @cards_data = build_cards_data
  end

  private

  def build_cards_data
    {
      games_count: Game.count,
      best_attack: Goal.joins(scorer: :team).group("teams.acronym").order("count_id desc").count(:id).first,
      best_scorer: Goal.joins(:scorer).group("players.name").order("count_id desc").count(:id).first,
    }
  end

  def build_chart_data(labels:, attributes:, type:)
    chart_data = {labels: labels, attributes: attributes, data: nil}
    chart_data[:data] = []

    if type == "goals_action_matchweek"
      query_results = Goal.joins(:game).group("games.matchweek", "goals.action_type").count
    elsif type == "goals_action_team"
      query_results = Goal.joins(scorer: :team).group("teams.acronym", "goals.action_type").count
    elsif type == "pie_team_goals"
      query_results = Goal.joins(scorer: :team).group("teams.acronym").count
    elsif type == "pie_action_goals"
      query_results = Goal.group(:action_type).count
    end

    if ["goals_action_matchweek", "goals_action_team"].include? type
      formatted_response = transform_query_group(query_results)

      attributes.each do |attribute|
        attribute_arr = []
        labels.each do |label|
          attribute_arr << (formatted_response.dig(label, attribute) || 0)
        end
        chart_data[:data] << attribute_arr
      end
    elsif ["pie_team_goals", "pie_action_goals"].include? type
      labels.each do |label|
        chart_data[:data] << (query_results[label] || 0)
      end
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
