import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="big-card"
export default class extends Controller {
  static targets = ["image", "name", "types", "details"]
  connect() {
    console.log("hey");
    console.log(this.element)
    console.log(this.imageTarget)
    console.log(this.nameTarget)
    console.log(this.typesTarget)
    console.log(this.detailsTarget)
  }

  showBigCard(event) {
    event.preventDefault()
    this.imageTarget.src = "<%= this.eventTarget.image_url"
  }
}
