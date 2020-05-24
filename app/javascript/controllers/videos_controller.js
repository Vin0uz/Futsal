import { Controller } from "stimulus"

export default class extends Controller {
  static targets = [ "list", "frame" ]

  connect(){
    this.element[this.identifier] = this
  }

  displayVideo(){
    if (this.listTarget.value){
      this.frameTarget.src = `https://www.youtube.com/embed/${this.listTarget.value}`
    }
    else{
      this.frameTarget.src = ""
      this.listTarget.innerHTML = "<option value=''>Aucune vidéo ne correspond aux filtres sélectionnés</option>"
    }
  }
}
