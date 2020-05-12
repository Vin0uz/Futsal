import  ChartController from "../chart_controller.js"
export default class extends ChartController {

  connect(){
    super.connect()
    this.initChart(this.chartType)
    this.refreshChart()
  }

  get apiUrl(){
    return "/api/team_goals"
  }

  get chartType(){
    return "doughnut"
  }
}
