require "csv"
require "open-uri"

class CalendarImporter
  MATCHWEEK = "Journees".freeze
  HOMETEAM = "Equipe_domicile".freeze
  AWAYTEAM = "Equipe_exterieur".freeze
  DATE = "Date".freeze

  def initialize(csv_path:)
    @csv = URI.open(csv_path)
  end

  def import
    CSV.foreach(@csv, col_sep: ",", headers: :first_row) do |row|
      ActiveRecord::Base.transaction do
        home = Team.find_by!(acronym: row[HOMETEAM])
        away = Team.find_by!(acronym: row[AWAYTEAM])
        game = Game.create(match_week: row[MATCHWEEK].delete("^0-9").to_i, date: row[DATE].to_date)
        game.team_games.create(team: home, home: true)
        game.team_games.create(team: away, home: false)
      end
      puts "."
    rescue StandardError => error
      raise StandardError.new("#{row[MATCHWEEK]} - #{row[HOMETEAM]} - #{row[AWAYTEAM]} : #{error}")
    end
  end
end
