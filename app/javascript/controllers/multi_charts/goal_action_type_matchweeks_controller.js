import  MultiChartController from "../multi_chart_controller.js"
export default class extends MultiChartController {

  connect(){
    super.connect()
    this.initChart(this.chartType)
    this.refreshChart()
  }

  get apiUrl(){
    return "/api/goal_action_type_matchweeks"
  }

  get chartType(){
    return "bar"
  }
}
