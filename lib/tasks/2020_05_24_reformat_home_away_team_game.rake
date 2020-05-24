namespace :temp do
  desc "Copy from home and away teams to TeamGame"
  task reformat_home_away_team_game: :environment do

    puts "Starting the moving"
    Game.find_each do |game|
      game.team_games.create!(team: game.home_team, home: true)
      game.team_games.create!(team: game.away_team, home: false)
      print "."
    end

    puts ""
    puts "Done."
  end
end
