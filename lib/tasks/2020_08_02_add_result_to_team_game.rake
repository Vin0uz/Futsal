namespace :temp do
  desc "Add result into team game"
  task add_result_to_team_game: :environment do
    puts "Starting to explore team_games"
    TeamGame.find_each do |team_game|
      game = team_game.game
      team = team_game.team.acronym
      opponent = (game.teams - [team]).first.acronym

      scored_goals = {}
      scored_goals[team] = 0
      scored_goals[opponent] = 0

      game.goals.each do |goal|
        marking = goal.scorer.team.acronym
        scored_goals[marking] += 1
      end

      if scored_goals[team] > scored_goals[opponent]
        team_game.update(result: "win")
      elsif scored_goals[team] == scored_goals[opponent]
        team_game.update(result: "draw")
      else
        team_game.update(result: "loss")
      end

      print "."
    end

    puts ""
    puts "Done."
  end
end
