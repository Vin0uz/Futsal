namespace :temp do
  desc "Read CSV file and create all games from it"
  task import_2020_calendar_csv: :environment do
    Team.create!(acronym: "ACCS", name: "ACCS Asnieres Villeneuve 92")
    Team.create!(acronym: "Herouville", name: "Herouville Futsal")
    Team.create!(acronym: "ACASA", name: "Paris ACASA")
    Team.create!(acronym: "Mouvaux", name: "Mouvaux Lille MF")
    Team.create!(acronym: "UJS", name: "UJS Toulouse")
    Team.create!(acronym: "Toulouse", name: "Toulouse Metropole Futsal")
    Team.create!(acronym: "NMF", name: "Nantes Metropole Futsal")
    Team.create!(acronym: "Sporting", name: "Sporting Club Paris")
    Team.create!(acronym: "Chavanoz", name: "FC Chavanoz")
    Team.create!(acronym: "Toulon", name: "Toulon Elite Futsal")
    Team.create!(acronym: "Garges", name: "Garges Djibson")
    Team.create!(acronym: "Bethune", name: "Bethune Futsal")

    before_count = Game.count
    calendar_csv_path = "https://docs.google.com/spreadsheets/d/e/2PACX-1vQ5u_UkNqwoDzXntvB3SUuTyyNkD_Tv0PEUONh4-x1Luy_NhHzrrZ1yxh1hLLLTMrTl-pkYiiTHPof4/pub?gid=10332592&single=true&output=csv"

    begin
      puts "Before calendar"
      CalendarImporter.new(csv_path: calendar_csv_path).import
      puts "#{Game.count - before_count} games added"
    rescue => e
      puts e
    end
  end
end
