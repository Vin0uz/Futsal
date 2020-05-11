namespace :temp do
  desc "Read CSV file and create all database from it"
  task import_database_csv: :environment do
    Team.create(acronym: "ACCES", name: "ACCS Futsal Club Paris VA 92")
    Team.create(acronym: "KB", name: "Kremlin-Bicetre Futsal")
    Team.create(acronym: "ACASA", name: "Paris ACASA Futsal")
    Team.create(acronym: "Roubaix", name: "Roubaix AFS")
    Team.create(acronym: "UJS", name: "U.J.S 31 Toulouse")
    Team.create(acronym: "Orchies", name: "Orchies Pevele")
    Team.create(acronym: "Toulouse", name: "Toulouse Métropole FC")
    Team.create(acronym: "NMF", name: "Nantes Métropole Futsal")
    Team.create(acronym: "Sporting", name: "Sporting Club Paris")
    Team.create(acronym: "Bethune", name: "Bethune Futsal")
    Team.create(acronym: "Toulon", name: "Toulon Elite Futsal")
    Team.create(acronym: "Garges", name: "Garges Djibson")

    before_count = Game.count
    calendar_csv_path = "https://vinouz.s3-eu-west-1.amazonaws.com/calendrier_d1.csv"
    goal_csv_path = "https://vinouz.s3-eu-west-1.amazonaws.com/goal_stats.csv"

    begin
      puts "Before calendar"
      CalendarImporter.new(csv_path: calendar_csv_path).import
      puts "#{Game.count - before_count} games added"
    rescue => e
      puts e
    end

    before_count = Goal.count
    begin
      GoalImporter.new(csv_path: goal_csv_path).import
      puts "#{Goal.count - before_count} goals added"
    rescue => e
      puts e
    end
  end
end
