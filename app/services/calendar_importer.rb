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
        Game.find_or_create_by!(matchweek: row[MATCHWEEK], home_team: home, away_team: away)
      end
      puts "."
    rescue StandardError => error
      raise StandardError.new("#{row[MATCHWEEK]} - #{row[HOMETEAM]} - #{row[AWAYTEAM]} : #{error}")
    end
  end
end
