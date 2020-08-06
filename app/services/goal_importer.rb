require "csv"
require "open-uri"

class GoalImporter
  MATCHWEEK = "Journee".freeze
  TEAM = "Equipes".freeze
  PLAYER = "Joueurs".freeze
  TYPE = "Types_actions".freeze
  YOUTUBE = "Youtube".freeze

  def initialize(csv_path:)
    @csv = URI.open(csv_path)
  end

  def import
    CSV.foreach(@csv, col_sep: ",", quote_char: '"', headers: :first_row) do |row|
      ActiveRecord::Base.transaction do
        team = Team.find_by!(acronym: row[TEAM])
        game = Game.joins(:teams).find_by(match_week: row[MATCHWEEK].delete("^0-9").to_i, teams: { id: team.id })
        if game.blank?
          raise "Game not found"
        end

        opponent = (game.teams - [team]).first
        team_game = TeamGame.find_or_create_by!(team: team, game: game)
        team_game_opponent = TeamGame.find_or_create_by!(team: opponent, game: game)

        player = Player.find_or_create_by!(name: row[PLAYER], team: team)
        Goal.create!(game: game, team: team, scorer: player, action_type: row[TYPE], youtube_id: row[YOUTUBE])
        update_score(game: team_game_opponent, type: "conceded")
        update_score(game: team_game, type: "scored")
      end
      puts "-"
    rescue StandardError => error
      raise StandardError.new("#{row[MATCHWEEK]} - #{row[TEAM]} : #{error}")
    end
  end

  def update_score(game:, type:)
    if type == "conceded"
      game.goals_conceded += 1
    elsif type == "scored"
      game.goals_scored += 1
    end

    if game.goals_scored > game.goals_conceded
      game.result = "win"
    elsif game.goals_scored == game.goals_conceded
      game.result = "draw"
    else
      game.result = "loss"
    end

    game.save!
  end
end
