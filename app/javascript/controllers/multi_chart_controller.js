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
    var ctx = document.getElementById(this.data.get("canvasId")).getContext('2d');
    this.chart = new Chart(ctx, {
      type: chartType,
      data: {},
      options: {
        scales: {
          yAxes: [{
            ticks: {
              beginAtZero: true
            }
          }]
        }
      }
    });
  }

  refreshChart() {
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
    var data = chartData.data
    var datasets = []
    var colors = this.colors
    var borderColors = this.borderColors
    Object.keys(data).forEach(function(label, index) {
      datasets.push({
        label: label,
        data: data[label],
        backgroundColor: colors[index]
      })
    });
    return {
      labels: labels,
      datasets: datasets
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
