import { Controller } from "stimulus"
import Chart from "chart.js"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = []

  connect(){
    document.addEventListener("updateCharts", this.refreshChart.bind(this))
  }

  disconnect(){
    document.removeEventListener("updateCharts", this.refreshChart.bind(this))
  }

  initChart(chartType) {
    var ctx = document.getElementById(this.data.get("canvasId")).getContext("2d");
    this.chart = new Chart(ctx, {
      type: chartType,
      data: {},
      options: {
        scales: {
        }
      }
    });
  }

  refreshChart() {
    if (this.data.has("params"))
      var params = this.data.get("params")
    else
      var params = document.querySelector("#filters").filters.urlParams

    fetch(`${this.apiUrl}?${params}`)
    .then(response => response.json())
    .then(chartData => {
      this.chart.config.data = this.refreshChartData(chartData)
      this.chart.update();
    })
  }

  refreshChartData(chartData){
    var labels = chartData.labels
    var hash_data = chartData.data
    var data = labels.map(label => hash_data.hasOwnProperty(label) ? hash_data[label] : 0)
    return {
      labels: labels,
      datasets: [{
        data: data,
        backgroundColor: this.colors,
        borderColor: "white",
        borderWidth: 2
      }]
    }
  }

  get colors(){
    return ["rgba(255, 99, 132, 1)",
      "rgba(255, 159, 64, 1)",
      "rgba(255, 205, 86, 1)",
      "rgba(75, 192, 192, 1)",
      "rgba(54, 162, 235, 1)",
      "rgba(153, 102, 255, 1)",
      "rgba(255, 99, 132, 1)",
      "rgba(255, 159, 64, 1)",
      "rgba(255, 205, 86, 1)",
      "rgba(75, 192, 192, 1)",
      "rgba(54, 162, 235, 1)",
      "rgba(153, 102, 255, 1)",
      "rgba(255, 99, 132, 1)",
      "rgba(255, 159, 64, 1)",
      "rgba(255, 205, 86, 1)",
      "rgba(75, 192, 192, 1)",
      "rgba(54, 162, 235, 1)",
      "rgba(153, 102, 255, 1)",
      "rgba(255, 99, 132, 1)",
      "rgba(255, 159, 64, 1)",
      "rgba(255, 205, 86, 1)",
      "rgba(75, 192, 192, 1)",
      "rgba(54, 162, 235, 1)",
      "rgba(153, 102, 255, 1)",
      "rgba(255, 99, 132, 1)",
      "rgba(255, 159, 64, 1)",
      "rgba(255, 205, 86, 1)",
      "rgba(75, 192, 192, 1)",
      "rgba(54, 162, 235, 1)",
      "rgba(153, 102, 255, 1)",
    ]
  }
}
