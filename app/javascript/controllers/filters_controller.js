import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "team", "actionType", "matchWeek" ]

  connect(){
    this.element[this.identifier] = this
    this.initTeamFilter()
    this.initActionTypeFilter()
    this.initMatchWeekFilter()
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

  initMatchWeekFilter(){
    var options = `<option value="">Toutes</option>`
    fetch(`api/games/match_weeks`)
    .then(response => response.json())
    .then( matchWeeks => {
      matchWeeks.forEach((matchWeek) => {
        options = options + this.optionTemplate(matchWeek, `J${matchWeek}`);
      });
      this.matchWeekTarget.innerHTML = options;
    });
  }

  optionTemplate(value, text){
    return `
    <option value=${value}>${text} </option>`
  }
}
