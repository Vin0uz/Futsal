require "csv"
require "open-uri"

class CalendarImporter
  MATCHWEEK = "Journees".freeze
  HOMETEAM = "Equipe_Domicile".freeze
  AWAYTEAM = "Equipe_Exterieur".freeze

  def initialize(csv_path:)
    @csv = URI.open(csv_path)
  end

  def import
    CSV.foreach(@csv, col_sep: ",", headers: :first_row) do |row|
      ActiveRecord::Base.transaction do
        home = Team.find_by!(acronym: row[HOMETEAM])
        away = Team.find_by!(acronym: row[AWAYTEAM])
        game = Game.find_or_create_by!(matchweek: row[MATCHWEEK])
        game.team_games.create(team: home, home: true)
        game.team_games.create(team: away, home: false)
      end
      puts "."
    rescue StandardError => error
      raise StandardError.new("#{row[MATCHWEEK]} - #{row[HOMETEAM]} - #{row[AWAYTEAM]} : #{error}")
    end
  end
end
