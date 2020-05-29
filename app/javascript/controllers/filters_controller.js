import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "team", "actionType", "matchWeek" ]

  connect(){
    this.element[this.identifier] = this
    this.refreshTeamFilter()
    this.refreshActionTypeFilter()
    this.refreshMatchWeekFilter()
  }

  triggerUpdate(){
    const updateCharts = new CustomEvent("updateCharts", {});
    document.dispatchEvent(updateCharts);
    this.refreshTeamFilter();
    this.refreshActionTypeFilter();
    this.refreshMatchWeekFilter();
  }

  refreshTeamFilter(){
    var options = `<option value="">Toutes</option>`
    var active = this.teamTarget.value
    fetch(`api/teams?${this.urlParams}`)
    .then(response => response.json())
    .then( teams => {
      teams.forEach((team) => {
        if (team.acronym == active){
          options = this.optionTemplate(team.acronym, team.name) + options;
        }
        else{
          options = options + this.optionTemplate(team.acronym, team.name);
        }
      });
      this.teamTarget.innerHTML = options;
    });
  }

  refreshActionTypeFilter(){
    var options = `<option value="">Toutes</option>`
    var active = this.actionTypeTarget.value
    fetch(`api/goals/action_types?${this.urlParams}`)
    .then(response => response.json())
    .then( action_types => {
      action_types.forEach((action_type) => {
        if (action_type == active){
          options = this.optionTemplate(action_type, action_type) + options;
        }
        else{
          options = options + this.optionTemplate(action_type, action_type);
        }
      });
      this.actionTypeTarget.innerHTML = options;
    });
  }

  refreshMatchWeekFilter(){
    var options = `<option value="">Toutes</option>`
    var active = this.matchWeekTarget.value
    fetch(`api/games/match_weeks?${this.urlParams}`)
    .then(response => response.json())
    .then( matchWeeks => {
      matchWeeks.forEach((matchWeek) => {
        if (matchWeek == active){
          options = this.optionTemplate(matchWeek, matchWeek) + options;
        }
        else{
          options = options + this.optionTemplate(matchWeek, matchWeek);
        }
      });
      this.matchWeekTarget.innerHTML = options;
    });
  }

  optionTemplate(value, text){
    return `
    <option value=${value}>${text} </option>`
  }

  get urlParams(){
    var team = this.teamTarget.value
    var action_type = this.actionTypeTarget.value
    var match_week = this.matchWeekTarget.value
    return `team=${team}&action_type=${action_type}&match_week=${match_week}`
  }

  loadListVideo(){
    var listTarget = document.querySelector("#videos").videos.listTarget
    var options = ""
    fetch(`api/goals/videos??${this.urlParams}`)
    .then(response => response.json())
    .then( goals => {
      goals.forEach((goal) => {
        options = options + this.optionTemplate(goal.youtube_id, `${goal.match_week} - ${goal.acronym} - ${goal.name} - ${goal.action_type}`);
      });
      listTarget.innerHTML = options;
      document.querySelector("#videos").videos.displayVideo()
    });
  }
}
