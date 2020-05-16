import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "team", "actionType", "matchweek" ]

  connect(){
    this.element[this.identifier] = this
    this.initTeamFilter()
    this.initActionTypeFilter()
    this.initMatchweekFilter()
  }

  triggerUpdate(){
    const updateCharts = new CustomEvent("updateCharts", {});
    document.dispatchEvent(updateCharts);
  }

  initTeamFilter(){
    var options = `<option value="">Toutes</option>`
    fetch(`api/teams`)
    .then(response => response.json())
    .then( teams => {
      teams.forEach((team) => {
        options = options + this.optionTemplate(team.acronym, team.name);
      });
      this.teamTarget.innerHTML = options;
    });
  }

  initActionTypeFilter(){
    var options = `<option value="">Toutes</option>`
    fetch(`api/goals/action_types`)
    .then(response => response.json())
    .then( action_types => {
      action_types.forEach((action_type) => {
        options = options + this.optionTemplate(action_type, action_type);
      });
      this.actionTypeTarget.innerHTML = options;
    });
  }

  initMatchweekFilter(){
    var options = `<option value="">Toutes</option>`
    fetch(`api/games/matchweeks`)
    .then(response => response.json())
    .then( matchweeks => {
      matchweeks.forEach((matchweek) => {
        options = options + this.optionTemplate(matchweek, matchweek);
      });
      this.matchweekTarget.innerHTML = options;
    });
  }

  optionTemplate(value, text){
    return `
    <option value=${value}>${text} </option>`
  }
}
