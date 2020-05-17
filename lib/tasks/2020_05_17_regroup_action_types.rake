namespace :temp do
  desc "Regroup existing action types into closer values"
  task regroup_action_types: :environment do
    STRATEGIE = ["Penalti", "10M", "Touche", "CPA", "Corner"].freeze
    ATTAQUE_PLACEE = ["4-0", "Pivot"].freeze
    POWERPLAY = ["Gardien_Joueur", "Defense_GJ"].freeze
    TRANSITION = ["Contre_attaque", "Pression", "Recup"].freeze

    puts "Starting the replacing"
    Goal.find_each do |goal|
      if STRATEGIE.include?(goal.action_type)
        goal.update_attributes(action_details: goal.action_type, action_type: "Strategie")
      elsif ATTAQUE_PLACEE.include?(goal.action_type)
        goal.update_attributes(action_details: goal.action_type, action_type: "Attaque_placee")
      elsif POWERPLAY.include?(goal.action_type)
        goal.update_attributes(action_details: goal.action_type, action_type: "Powerplay")
      elsif TRANSITION.include?(goal.action_type)
        goal.update_attributes(action_details: goal.action_type, action_type: "Transition")
      end
      print "."
    end

    puts ""
    puts "Done."
  end
end
