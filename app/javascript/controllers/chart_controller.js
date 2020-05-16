import { Controller } from "stimulus"
import Chart from "chart.js"
import Rails from "@rails/ujs";

export default class extends Controller {
  static targets = []

  connect(){
    this.initChart()
    this.refreshChart()
  }

  initChart() {
    var ctx = document.getElementById(this.data.get("canvasId")).getContext('2d');
    this.chart = new Chart(ctx, {
      type: this.data.get("chartType"),
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
    fetch(`api/${this.type}`)
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
        borderColor: this.borderColors,
        borderWidth: 1
      }]
    }
  }

  get type(){
    return this.data.get("dataset")
  }

  get colors(){
    return ["rgba(255, 99, 132, 0.5)",
      "rgba(255, 159, 64, 0.5)",
      "rgba(255, 205, 86, 0.5)",
      "rgba(75, 192, 192, 0.5)",
      "rgba(54, 162, 235, 0.5)",
      "rgba(153, 102, 255, 0.5)",
      "rgba(255, 99, 132, 0.5)",
      "rgba(255, 159, 64, 0.5)",
      "rgba(255, 205, 86, 0.5)",
      "rgba(75, 192, 192, 0.5)",
      "rgba(54, 162, 235, 0.5)",
      "rgba(153, 102, 255, 0.5)",
      "rgba(255, 99, 132, 0.5)",
      "rgba(255, 159, 64, 0.5)",
      "rgba(255, 205, 86, 0.5)",
      "rgba(75, 192, 192, 0.5)",
      "rgba(54, 162, 235, 0.5)",
      "rgba(153, 102, 255, 0.5)",
      "rgba(255, 99, 132, 0.5)",
      "rgba(255, 159, 64, 0.5)",
      "rgba(255, 205, 86, 0.5)",
      "rgba(75, 192, 192, 0.5)",
      "rgba(54, 162, 235, 0.5)",
      "rgba(153, 102, 255, 0.5)",
      "rgba(255, 99, 132, 0.5)",
      "rgba(255, 159, 64, 0.5)",
      "rgba(255, 205, 86, 0.5)",
      "rgba(75, 192, 192, 0.5)",
      "rgba(54, 162, 235, 0.5)",
      "rgba(153, 102, 255, 0.5)",
    ]
  }

  get borderColors(){
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
