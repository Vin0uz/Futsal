// hello_controller.js
import { Controller } from "stimulus"
import Chart from "chart.js"

export default class extends Controller {
  static targets = [ "labels", "data", "datasetLabels" ]

  connect(){
    var ctx = document.getElementById(this.data.get("canvasId")).getContext('2d');
    var labels = this.labels
    var length = labels.length
    var myChart = new Chart(ctx, {
      type: "bar",
      data: {
        labels: this.labels,
        datasets: this.datasets
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

  get datasets() {
    var datasets = []
    var hash = {}
    var data = this.dataChart
    const COLORS = this.colors
    const BORDER_COLORS = this.borderColors
    this.dataset_labels.forEach(function (action_type, j){
      hash = {}
      hash.label = action_type
      hash.data = data[j]
      hash.backgroundColor = COLORS[j]
      hash.borderColor = BORDER_COLORS[j]
      hash.borderWidth = 1
      datasets.push(hash)
    });

    return datasets
  }

  get dataset_labels(){
    return JSON.parse(this.datasetLabelsTarget.dataset.value)
  }

  get dataChart(){
    return JSON.parse(this.dataTarget.dataset.value)
  }

  colorArray(color, count) {
    var bgColors = [];
    for (var i = 0; i < count; i++) {
      bgColors.push(color);
    }
    return bgColors
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
  //[{
  //        label: "Autres",
  //       data: [12, 19, 3, 5, 2, 3],
  //        backgroundColor: this.colorArray("rgba(255, 99, 132, 0.2)", length),
  //        borderColor: this.colorArray("rgba(255, 99, 132, 1)", length),
  //        borderWidth: 1
  //      },
  //      {
  //        label: "Strategie",
  //        data: [1, 3, 7, 1, 2, 3],
  //        backgroundColor: this.colorArray("rgba(255, 159, 64, 0.2)", length),
  //        borderColor: this.colorArray("rgba(255, 159, 64, 1)", length),
  //        borderWidth: 1
  //      }]
}
