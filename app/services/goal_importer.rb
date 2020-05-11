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
        game = Game.find_by(matchweek: row[MATCHWEEK], home_team: team) || Game.find_by(matchweek: row[MATCHWEEK], away_team: team)
        if game.blank?
          raise "Game not found"
        end

        player = Player.find_or_create_by!(team: team, name: row[PLAYER])
        Goal.find_or_create_by!(game: game, scorer: player, action_type: row[TYPE], youtube_id: row[YOUTUBE])
      end
      puts "-"
    rescue StandardError => error
      raise StandardError.new("#{row[MATCHWEEK]} - #{row[TEAM]} : #{error}")
    end
  end
end
