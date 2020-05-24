namespace :temp do
  desc "Copy from str matchweek to int match_week"
  task build_match_week_integer: :environment do

    puts "Starting the moving"
    Game.find_each do |game|
      match_week = game.matchweek.delete("^0-9").to_i
      game.update!(match_week: match_week)
      print "."
    end

    puts ""
    puts "Done."
  end
end
