// hello_controller.js
import { Controller } from "stimulus"
import Chart from "chart.js"

export default class extends Controller {
  static targets = [ "labels", "data", "datasetLabels" ]

  connect(){
    var ctx = document.getElementById(this.data.get("canvasId")).getContext('2d');
    var labels = this.labels
    var myChart = new Chart(ctx, {
      type: this.data.get("chartType"),
      data: {
        labels: this.labels,
        datasets: [{
          data: this.dataChart,
          backgroundColor: this.colors,
          borderColor: this.borderColors,
          borderWidth: 1
        }]
      },
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

  get labels() {
    return JSON.parse(this.labelsTarget.dataset.value)
  }

  get dataChart(){
    return JSON.parse(this.dataTarget.dataset.value)
  }

  get colors(){
    return ["rgba(255, 99, 132, 0.5)",
      "rgba(255, 159, 64, 0.5)",
      "rgba(255, 205, 86, 0.5)",
      "rgba(75, 192, 192, 0.5)",
      "rgba(54, 162, 235, 0.5)",
      "rgba(153, 102, 255, 0.5)"
    ]
  }

  get borderColors(){
    return ["rgba(255, 99, 132, 1)",
      "rgba(255, 159, 64, 1)",
      "rgba(255, 205, 86, 1)",
      "rgba(75, 192, 192, 1)",
      "rgba(54, 162, 235, 1)",
      "rgba(153, 102, 255, 1)"
    ]
  }
}
