if Rails.env.development? || Rails.env.test?

  namespace :dev do
    desc "Sample data for local development environment"
    task prime: "db:setup" do
      nfm = Team.create(name: "Nantes Football Metropole", acronym: "NFM")
      ujs = Team.create(name: "Toulouse UJS", acronym: "UJS")

      nfm_bryan = Player.create(team: nfm, name: "Bryan")
      nfm_steve = Player.create(team: nfm, name: "Steve")
      nfm_wilmer = Player.create(team: nfm, name: "Wilmer")
      nfm_diden = Player.create(team: nfm, name: "Diden")

      ujs_derrouaz = Player.create(team: ujs, name: "Derrouaz")
      ujs_ahssen = Player.create(team: ujs, name: "Ahssen")

      game = Game.create(match_week: 1, date: "14/09/2019".to_date)
      game.team_games.create(team: ujs, home: true)
      game.team_games.create(team: nfm, home: false)

      Goal.create(game: game, scorer: nfm_bryan, action_type: "out_press")
      Goal.create(game: game, scorer: nfm_steve, action_type: "out_press")
      Goal.create(game: game, scorer: nfm_steve, action_type: "placed_attack")
      Goal.create(game: game, scorer: nfm_wilmer, action_type: "other")
      Goal.create(game: game, scorer: nfm_diden, action_type: "pressing")

      Goal.create(game: game, scorer: ujs_derrouaz, action_type: "placed_attack")
      Goal.create(game: game, scorer: ujs_ahssen, action_type: "10m")
    end
  end
end
